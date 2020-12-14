Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449A92D9796
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438378AbgLNLnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:43:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:33866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437909AbgLNLmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:42:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8ADACAC10;
        Mon, 14 Dec 2020 11:42:04 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:42:00 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/SGX for v5.11
Message-ID: <20201214114200.GD26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the Intel Software Guard eXtensions enablement. This has
been long in the making, we were one revision number short of 42. :)

Thx.

---

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.11

for you to fetch changes up to a4b9c48b96517ff4780b22a784e7537eac5dc21b:

  x86/sgx: Return -EINVAL on a zero length buffer in sgx_ioc_enclave_add_pages() (2020-12-03 19:54:40 +0100)

----------------------------------------------------------------
"Intel SGX is new hardware functionality that can be used by
applications to populate protected regions of user code and data called
enclaves. Once activated, the new hardware protects enclave code and
data from outside access and modification.

Enclaves provide a place to store secrets and process data with those
secrets. SGX has been used, for example, to decrypt video without
exposing the decryption keys to nosy debuggers that might be used to
subvert DRM. Software has generally been rewritten specifically to
run in enclaves, but there are also projects that try to run limited
unmodified software in enclaves."

Most of the functionality is concentrated into arch/x86/kernel/cpu/sgx/
except the addition of a new mprotect() hook to control enclave page
permissions and support for vDSO exceptions fixup which will is used by
SGX enclaves.

All this work by Sean Christopherson, Jarkko Sakkinen and many others.

----------------------------------------------------------------
Borislav Petkov (1):
      x86/sgx: Fix sgx_ioc_enclave_provision() kernel-doc comment

Dave Hansen (1):
      x86/sgx: Clarify 'laundry_list' locking

Jarkko Sakkinen (17):
      x86/sgx: Add SGX architectural data structures
      x86/sgx: Add wrappers for ENCLS functions
      x86/cpu/intel: Add a nosgx kernel parameter
      x86/sgx: Add SGX page allocator functions
      x86/sgx: Add an SGX misc driver interface
      x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
      x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES
      x86/sgx: Add SGX_IOC_ENCLAVE_INIT
      x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION
      selftests/x86: Add a selftest for SGX
      x86/sgx: Add a page reclaimer
      x86/sgx: Add ptrace() support for the SGX driver
      Documentation/x86: Document SGX kernel architecture
      x86/sgx: Update MAINTAINERS
      selftests/sgx: Use a statically generated 3072-bit RSA key
      x86/sgx: Return -ERESTARTSYS in sgx_ioc_enclave_add_pages()
      x86/sgx: Return -EINVAL on a zero length buffer in sgx_ioc_enclave_add_pages()

Mauro Carvalho Chehab (1):
      x86/sgx: Fix a typo in kernel-doc markup

Sean Christopherson (10):
      x86/cpufeatures: Add Intel SGX hardware bits
      x86/{cpufeatures,msr}: Add Intel SGX Launch Control hardware bits
      x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections
      x86/mm: Signal SIGSEGV with PF_SGX
      x86/cpu/intel: Detect SGX support
      mm: Add 'mprotect' hook to struct vm_operations_struct
      x86/vdso: Add support for exception fixup in vDSO functions
      x86/fault: Add a helper function to sanitize error code
      x86/traps: Attempt to fixup exceptions in vDSO before signaling
      x86/vdso: Implement a vDSO for Intel SGX enclave call

 Documentation/admin-guide/kernel-parameters.txt    |   2 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 Documentation/x86/index.rst                        |   1 +
 Documentation/x86/sgx.rst                          | 211 ++++++
 MAINTAINERS                                        |  13 +
 arch/x86/Kconfig                                   |  17 +
 arch/x86/entry/vdso/Makefile                       |   8 +-
 arch/x86/entry/vdso/extable.c                      |  46 ++
 arch/x86/entry/vdso/extable.h                      |  28 +
 arch/x86/entry/vdso/vdso-layout.lds.S              |   9 +-
 arch/x86/entry/vdso/vdso.lds.S                     |   1 +
 arch/x86/entry/vdso/vdso2c.h                       |  50 +-
 arch/x86/entry/vdso/vsgx.S                         | 151 +++++
 arch/x86/include/asm/cpufeatures.h                 |   2 +
 arch/x86/include/asm/disabled-features.h           |   8 +-
 arch/x86/include/asm/enclu.h                       |   9 +
 arch/x86/include/asm/msr-index.h                   |   8 +
 arch/x86/include/asm/trap_pf.h                     |   2 +
 arch/x86/include/asm/vdso.h                        |   5 +
 arch/x86/include/uapi/asm/sgx.h                    | 168 +++++
 arch/x86/kernel/cpu/Makefile                       |   1 +
 arch/x86/kernel/cpu/feat_ctl.c                     |  38 +-
 arch/x86/kernel/cpu/sgx/Makefile                   |   5 +
 arch/x86/kernel/cpu/sgx/arch.h                     | 338 ++++++++++
 arch/x86/kernel/cpu/sgx/driver.c                   | 194 ++++++
 arch/x86/kernel/cpu/sgx/driver.h                   |  29 +
 arch/x86/kernel/cpu/sgx/encl.c                     | 740 +++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h                     | 119 ++++
 arch/x86/kernel/cpu/sgx/encls.h                    | 231 +++++++
 arch/x86/kernel/cpu/sgx/ioctl.c                    | 716 ++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c                     | 733 ++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h                      |  86 +++
 arch/x86/kernel/traps.c                            |  10 +
 arch/x86/mm/fault.c                                |  45 +-
 include/linux/mm.h                                 |   7 +
 mm/mprotect.c                                      |   7 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sgx/.gitignore             |   2 +
 tools/testing/selftests/sgx/Makefile               |  57 ++
 tools/testing/selftests/sgx/call.S                 |  44 ++
 tools/testing/selftests/sgx/defines.h              |  21 +
 tools/testing/selftests/sgx/load.c                 | 277 ++++++++
 tools/testing/selftests/sgx/main.c                 | 246 +++++++
 tools/testing/selftests/sgx/main.h                 |  41 ++
 tools/testing/selftests/sgx/sign_key.S             |  12 +
 tools/testing/selftests/sgx/sign_key.pem           |  39 ++
 tools/testing/selftests/sgx/sigstruct.c            | 381 +++++++++++
 tools/testing/selftests/sgx/test_encl.c            |  20 +
 tools/testing/selftests/sgx/test_encl.lds          |  40 ++
 tools/testing/selftests/sgx/test_encl_bootstrap.S  |  89 +++
 50 files changed, 5290 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/x86/sgx.rst
 create mode 100644 arch/x86/entry/vdso/extable.c
 create mode 100644 arch/x86/entry/vdso/extable.h
 create mode 100644 arch/x86/entry/vdso/vsgx.S
 create mode 100644 arch/x86/include/asm/enclu.h
 create mode 100644 arch/x86/include/uapi/asm/sgx.h
 create mode 100644 arch/x86/kernel/cpu/sgx/Makefile
 create mode 100644 arch/x86/kernel/cpu/sgx/arch.h
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.c
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.h
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.c
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.h
 create mode 100644 arch/x86/kernel/cpu/sgx/encls.h
 create mode 100644 arch/x86/kernel/cpu/sgx/ioctl.c
 create mode 100644 arch/x86/kernel/cpu/sgx/main.c
 create mode 100644 arch/x86/kernel/cpu/sgx/sgx.h
 create mode 100644 tools/testing/selftests/sgx/.gitignore
 create mode 100644 tools/testing/selftests/sgx/Makefile
 create mode 100644 tools/testing/selftests/sgx/call.S
 create mode 100644 tools/testing/selftests/sgx/defines.h
 create mode 100644 tools/testing/selftests/sgx/load.c
 create mode 100644 tools/testing/selftests/sgx/main.c
 create mode 100644 tools/testing/selftests/sgx/main.h
 create mode 100644 tools/testing/selftests/sgx/sign_key.S
 create mode 100644 tools/testing/selftests/sgx/sign_key.pem
 create mode 100644 tools/testing/selftests/sgx/sigstruct.c
 create mode 100644 tools/testing/selftests/sgx/test_encl.c
 create mode 100644 tools/testing/selftests/sgx/test_encl.lds
 create mode 100644 tools/testing/selftests/sgx/test_encl_bootstrap.S

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
