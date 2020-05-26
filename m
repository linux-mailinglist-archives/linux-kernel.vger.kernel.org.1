Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6B1D4255
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEOAr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 20:47:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:10300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgEOAr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:47:26 -0400
IronPort-SDR: p+DxWomsou58vwUhATjLIrflDsVQwp7yf1vKwT+90FZEl/v3A5cZarohlyH0z4YY/qZEcce/t9
 uY/UoJ27x5dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 17:47:26 -0700
IronPort-SDR: WOVDQOhbiRtq/+ngLGOEDorHOfFpTUbWuQvaw7AxzDaYomlT3RCBO1WQAj8TInyP2P1yiqnUOy
 ZXwUw0r32/eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="253644545"
Received: from ashadrin-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.38.112])
  by fmsmga008.fm.intel.com with ESMTP; 14 May 2020 17:47:18 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v30 19/20] docs: x86/sgx: Document SGX micro architecture and kernel internals
Date:   Fri, 15 May 2020 03:44:09 +0300
Message-Id: <20200515004410.723949-20-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Intel SGX kernel architecture. The fine-grained micro
architecture details can be looked up from Intel SDM Volume 3D.

Cc: linux-doc@vger.kernel.org
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/x86/index.rst |   1 +
 Documentation/x86/sgx.rst   | 206 ++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 Documentation/x86/sgx.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 265d9e9a093b..807290bf357c 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -30,3 +30,4 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   sgx
diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
new file mode 100644
index 000000000000..9609a3409ad1
--- /dev/null
+++ b/Documentation/x86/sgx.rst
@@ -0,0 +1,206 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Architecture
+============
+
+*Software Guard eXtensions (SGX)* is a set of instructions that enable ring-3
+applications to set aside private regions of code and data. These regions are
+called enclaves. An enclave can be entered to a fixed set of entry points. Only
+a CPU running inside the enclave can access its code and data.
+
+The support can be determined by
+
+	``grep sgx /proc/cpuinfo``
+
+Enclave Page Cache
+==================
+
+SGX utilizes an *Enclave Page Cache (EPC)* to store pages that are associated
+with an enclave. It is contained in a BIOS reserved region of physical memory.
+Unlike pages used for regular memory, pages can only be accessed outside the
+enclave for different purposes with the instructions **ENCLS**, **ENCLV** and
+**ENCLU**.
+
+Direct memory accesses to an enclave can be only done by a CPU executing inside
+the enclave. An enclave can be entered with **ENCLU[EENTER]** to a fixed set of
+entry points. However, a CPU executing inside the enclave can do outside memory
+accesses.
+
+Page Types
+----------
+
+**SGX Enclave Control Structure (SECS)**
+   Enclave's address range, attributes and other global data are defined
+   by this structure.
+
+**Regular (REG)**
+   Regular EPC pages contain the code and data of an enclave.
+
+**Thread Control Structure (TCS)**
+   Thread Control Structure pages define the entry points to an enclave and
+   track the execution state of an enclave thread.
+
+**Version Array (VA)**
+   Version Array pages contain 512 slots, each of which can contain a version
+   number for a page evicted from the EPC.
+
+Enclave Page Cache Map
+----------------------
+
+The processor tracks EPC pages via the *Enclave Page Cache Map (EPCM)*.  EPCM
+contains an entry for each EPC page, which describes the owning enclave, access
+rights and page type among the other things.
+
+The permissions from EPCM is consulted if and only if walking the kernel page
+tables succeeds. The total permissions are thus a conjunction between page table
+and EPCM permissions.
+
+For all intents and purposes the SGX architecture allows the processor to
+invalidate all EPCM entries at will, i.e. requires that software be prepared to
+handle an EPCM fault at any time. The contents of EPC are encrypted with an
+ephemeral key, which is lost on power transitions.
+
+EPC management
+==============
+
+EPC pages do not have ``struct page`` instances. They are IO memory from kernel
+perspective. The consequence is that they are always mapped as shared memory.
+Kernel defines ``/dev/sgx/enclave`` that can be mapped as ``MAP_SHARED`` to
+define the address range for an enclave.
+
+EPC Over-subscription
+=====================
+
+When the amount of free EPC pages goes below a low watermark the swapping thread
+starts reclaiming pages. The pages that do not have the **A** bit set are
+selected as victim pages.
+
+Launch Control
+==============
+
+SGX provides a launch control mechanism. After all enclave pages have been
+copied, kernel executes **ENCLS[EINIT]**, which initializes the enclave. Only
+after this the CPU can execute inside the enclave.
+
+This leaf function takes an RSA-3072 signature of the enclave measurement and an
+optional cryptographic token. Linux does not take advantage of launch tokens.
+The instruction checks that the signature is signed with the key defined in
+**IA32_SGXLEPUBKEYHASH?** MSRs and the measurement is correct. If so, the
+enclave is allowed to be executed.
+
+MSRs can be configured by the BIOS to be either readable or writable. Linux
+supports only writable configuration in order to give full control to the kernel
+on launch control policy. Readable configuration requires the use of previously
+mentioned launch tokens.
+
+The current kernel implementation supports only writable MSRs. The launch is
+performed by setting the MSRs to the hash of the enclave signer's public key.
+The alternative would be to have *a launch enclave* that would be signed with
+the key set into MSRs, which would then generate launch tokens for other
+enclaves. This would only make sense with read-only MSRs, and thus the option
+has been discarded.
+
+Attestation
+===========
+
+Local Attestation
+-----------------
+
+In local attestation an enclave creates a **REPORT** data structure with
+**ENCLS[EREPORT]**, which describes the origin of an enclave. In particular, it
+contains a AES-CMAC of the enclave contents signed with a report key unique to
+each processor. All enclaves have access to this key.
+
+This mechanism can also be used in addition as a communication channel as the
+**REPORT** data structure includes a 64-byte field for variable information.
+
+Remote Attestation
+------------------
+
+For remote attestation (or provisioning) there are schemes available:
+
+* EPID scheme, which requires the use of Intel managed attestation service.
+* ECDSA scheme, which allows a 3rd party to act as an attestation service.
+
+Intel has released an open source *Quoting Enclave (QE)* and *Provisioning
+Certification Enclave (PCE)* for the ECDSA based scheme. A PCE is used to
+certify the locally used QE's.
+
+Intel also provides a proprietary of the PCE. This is a necessary when one
+needs to be able to prove that an enclave is running on real hardware. To
+achieve this the enclave needs to be rooted to the Intel's PKI, which obviously
+cannot be exposed to 3rd parties.
+
+Both schemes require **ATTRIBUTES.PROVISIONKEY** but only EPID scheme uses the
+on-die provisioning key. This privilege should be under normal conditions given
+only to QE's because uncontrolled use of attestation could be used by malware
+for benefit.
+
+Encryption engines
+==================
+
+In order to conceal the enclave data while it is out of the CPU package,
+memory controller has to be extended with an encryption engine. MC can then
+route incoming requests coming from CPU cores running in enclave mode to the
+encryption engine.
+
+In CPUs prior to Icelake, Memory Encryption Engine (MEE) is used to
+encrypt pages leaving the CPU caches. MEE uses a n-ary Merkle tree with root in
+SRAM to maintain integrity of the encrypted data. This provides integrity and
+anti-replay protection but does not scale to large memory sizes because the time
+required to update the Merkle tree grows logarithmically in relation to the
+memory size.
+
+CPUs starting from Icelake use Total Memory Encryption (TME) in the place of
+MEE. TME throws away the Merkle tree, which means losing integrity and
+anti-replay protection but also enables variable size memory pools for EPC.
+Using this attack for benefit would require an interposer on the system bus.
+
+Backing storage
+===============
+
+Backing storage is shared and not accounted. It is implemented as a private
+shmem file. Providing a backing storage in some form from user space is not
+possible - accounting would go to invalid state as reclaimed pages would get
+accounted to the processes of which behalf the kernel happened to be acting on.
+
+Access control
+==============
+
+`mmap()` permissions are capped by the enclave permissions. A direct
+consequence of this is that all the pages for an address range must be added
+before `mmap()` can be applied. Effectively an enclave page with minimum
+permission in the address range sets the permission cap for the mapping
+operation.
+
+Usage Models
+============
+
+Shared Library
+--------------
+
+Sensitive data and the code that acts on it is partitioned from the application
+into a separate library. The library is then linked as a DSO which can be loaded
+into an enclave. The application can then make individual function calls into
+the enclave through special SGX instructions. A run-time within the enclave is
+configured to marshal function parameters into and out of the enclave and to
+call the correct library function.
+
+Application Container
+---------------------
+
+An application may be loaded into a container enclave which is specially
+configured with a library OS and run-time which permits the application to run.
+The enclave run-time and library OS work together to execute the application
+when a thread enters the enclave.
+
+References
+==========
+
+"Intel® Software Guard Extensions: EPID Provisioning and Attestation Services"
+   https://software.intel.com/sites/default/files/managed/57/0e/ww10-2016-sgx-provisioning-and-attestation-final.pdf
+
+"Supporting Third Party Attestation for Intel® SGX with Intel® Data Center
+Attestation Primitives"
+   https://software.intel.com/sites/default/files/managed/f1/b8/intel-sgx-support-for-third-party-attestation.pdf
-- 
2.25.1

