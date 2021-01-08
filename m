Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62882EED71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 07:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbhAHG1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 01:27:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:7276 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbhAHG1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:27:15 -0500
IronPort-SDR: rb4lA66d0sihkQiWcDM1ysYYZspI/o0L6Wm8g6f+ky8dzwJ68VCxBIY/U5ZvjkXftK5qnu9Q5o
 gQDRBSTzdcTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="241624217"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="xz'?yaml'?scan'208";a="241624217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:26:09 -0800
IronPort-SDR: AvYOlFDSPxORqFOtvoO9V/HjTsTmdepo0STkrGTvQfIEn9WZEyL82GIPeQm5KXeUpkVjVRImqT
 2dMVmeiPXBVA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="xz'?yaml'?scan'208";a="351581904"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:26:04 -0800
Date:   Fri, 8 Jan 2021 14:41:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Vadim Fedorenko <vfedorenko@novek.ru>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [selftests/tls]  4f336e88a8: kernel-selftests.net.make_fail
Message-ID: <20210108064141.GB3437@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 4f336e88a870ecc56832154dff22853a3ca33e24 ("selftests/tls: add CHACHA20-POLY1305 to tls selftests")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: kernel-selftests
version: kernel-selftests-x86_64-cb0debfe-1_20201231
with following parameters:

	group: net
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 28G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24
2021-01-07 17:07:57 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP WARN miss config CONFIG_BAREUDP= of net/config
2021-01-07 17:07:57 make -C bpf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf'
  MKDIR    include
  MKDIR    libbpf
  HOSTCC   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/fixdep.o
  HOSTLD   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/fixdep-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/fixdep
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so.0.3.0
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.pc
  INSTALL  headers
  CC       test_stub.o
  BINARY   test_verifier
  BINARY   test_tag
  MKDIR    bpftool
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/map_perf_ring.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/iter.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/tracelog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/link.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/perf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/btf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/libbpf.a
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/libbpf.a
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/profiler.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/profiler.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/prog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/net.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/struct_ops.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/netlink_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/cgroup.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/cfg.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/map.o
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/pids.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/feature.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/jit_disasm.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/disasm.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/bpftool
  INSTALL  bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-perf.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-map.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-link.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-iter.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-net.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-struct_ops.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-feature.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-prog.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-gen.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-cgroup.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-btf.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpf-helpers.rst
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpf-helpers.7
  INSTALL  eBPF_helpers-manpage
  INSTALL  Documentation-man
  GEN      vmlinux.h
  CLNG-LLC [test_maps] pyperf_global.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___extra_nesting.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___fn_wrong_args.o
  CLNG-LLC [test_maps] test_global_data.o
  CLNG-LLC [test_maps] test_global_func8.o
  CLNG-LLC [test_maps] test_ksyms_btf_null_check.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_container.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_sz.o
  CLNG-LLC [test_maps] bpf_iter_test_kern5.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___reverse_sign.o
  CLNG-LLC [test_maps] test_cls_redirect_subprogs.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_ptr.o
  CLNG-LLC [test_maps] test_core_reloc_nesting.o
  CLNG-LLC [test_maps] bpf_iter_test_kern2.o
  CLNG-LLC [test_maps] test_cls_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___incompat.o
  CLNG-LLC [test_maps] loop5.o
  CLNG-LLC [test_maps] test_btf_newkv.o
  CLNG-LLC [test_maps] pyperf600.o
  CLNG-LLC [test_maps] profiler2.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf3.o
  CLNG-LLC [test_maps] trigger_bench.o
  CLNG-LLC [test_maps] test_probe_user.o
  CLNG-LLC [test_maps] tailcall3.o
  CLNG-LLC [test_maps] bpf_iter_bpf_hash_map.o
  CLNG-LLC [test_maps] test_endian.o
  CLNG-LLC [test_maps] xdp_redirect_map.o
  CLNG-LLC [test_maps] local_storage.o
  CLNG-LLC [test_maps] test_get_stack_rawtp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___struct_union_mixup.o
  CLNG-LLC [test_maps] test_core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting.o
  CLNG-LLC [test_maps] test_tracepoint.o
  CLNG-LLC [test_maps] test_xdp_bpf2bpf.o
  CLNG-LLC [test_maps] test_core_retro.o
  CLNG-LLC [test_maps] test_send_signal_kern.o
  CLNG-LLC [test_maps] test_tcp_estats.o
  CLNG-LLC [test_maps] test_global_func2.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___equiv_zero_sz_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___diff_sz.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_dup_incompat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id___missing_targets.o
  CLNG-LLC [test_maps] test_hash_large_key.o
  CLNG-LLC [test_maps] test_sockmap_listen.o
  CLNG-LLC [test_maps] test_global_func7.o
  CLNG-LLC [test_maps] test_xdp_with_devmap_helpers.o
  CLNG-LLC [test_maps] test_xdp_with_cpumap_helpers.o
  CLNG-LLC [test_maps] udp_limit.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_struct_type.o
  CLNG-LLC [test_maps] bpf_iter_test_kern6.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id.o
  CLNG-LLC [test_maps] test_core_extern.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_field.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_int.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_nonstruct_container.o
  CLNG-LLC [test_maps] test_link_pinning.o
  CLNG-LLC [test_maps] pyperf600_nounroll.o
  CLNG-LLC [test_maps] test_ksyms_btf.o
  CLNG-LLC [test_maps] lsm.o
  CLNG-LLC [test_maps] loop2.o
  CLNG-LLC [test_maps] sample_map_ret0.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___err_missing.o
  CLNG-LLC [test_maps] test_rdonly_maps.o
  CLNG-LLC [test_maps] test_sk_lookup_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
  CLNG-LLC [test_maps] test_vmlinux.o
  CLNG-LLC [test_maps] test_ringbuf.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields.o
  CLNG-LLC [test_maps] sample_ret0.o
  CLNG-LLC [test_maps] loop1.o
  CLNG-LLC [test_maps] test_map_in_map.o
  CLNG-LLC [test_maps] freplace_connect_v4_prog.o
  CLNG-LLC [test_maps] test_l4lb_noinline.o
  CLNG-LLC [test_maps] test_l4lb.o
  CLNG-LLC [test_maps] sockopt_multi.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf2.o
  CLNG-LLC [test_maps] test_trace_ext.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___anon_embed.o
  CLNG-LLC [test_maps] test_cgroup_link.o
  CLNG-LLC [test_maps] bpf_iter_bpf_sk_storage_map.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_direct.o
  CLNG-LLC [test_maps] fmod_ret_freplace.o
  CLNG-LLC [test_maps] netif_receive_skb.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_non_array.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf1.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_too_deep.o
  CLNG-LLC [test_maps] test_pinning_invalid.o
  CLNG-LLC [test_maps] btf_dump_test_case_packing.o
  CLNG-LLC [test_maps] test_sockmap_update.o
  CLNG-LLC [test_maps] sockmap_tcp_msg_prog.o
  CLNG-LLC [test_maps] ringbuf_bench.o
  CLNG-LLC [test_maps] test_verif_scale3.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_shallow.o
  CLNG-LLC [test_maps] test_core_reloc_size.o
  CLNG-LLC [test_maps] connect_force_port4.o
  CLNG-LLC [test_maps] test_core_reloc_flavors.o
  CLNG-LLC [test_maps] test_enable_stats.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_enum_def.o
  CLNG-LLC [test_maps] test_global_func5.o
  CLNG-LLC [test_maps] get_cgroup_id_kern.o
  CLNG-LLC [test_maps] strobemeta_nounroll2.o
  CLNG-LLC [test_maps] trace_printk.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_array_map.o
  CLNG-LLC [test_maps] fexit_test.o
  CLNG-LLC [test_maps] test_skmsg_load_helpers.o
  CLNG-LLC [test_maps] bpf_iter_netlink.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_kind.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_shrink.o
  CLNG-LLC [test_maps] test_core_reloc_mods.o
  CLNG-LLC [test_maps] test_tcp_hdr_options.o
  CLNG-LLC [test_maps] bpf_iter_bpf_array_map.o
  CLNG-LLC [test_maps] test_tc_neigh_fib.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] cg_storage_multi_isolated.o
  CLNG-LLC [test_maps] test_tc_peer.o
  CLNG-LLC [test_maps] sockmap_parse_prog.o
  CLNG-LLC [test_maps] cg_storage_multi_egress_only.o
  CLNG-LLC [test_maps] test_xdp_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___typedefs.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___val3_missing.o
  CLNG-LLC [test_maps] test_sysctl_prog.o
  CLNG-LLC [test_maps] sockmap_verdict_prog.o
  CLNG-LLC [test_maps] test_probe_read_user_str.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_small.o
  CLNG-LLC [test_maps] test_xdp_vlan.o
  CLNG-LLC [test_maps] bpf_iter_tcp6.o
  CLNG-LLC [test_maps] test_global_func4.o
  CLNG-LLC [test_maps] test_stacktrace_map.o
  CLNG-LLC [test_maps] test_skeleton.o
  CLNG-LLC [test_maps] test_btf_nokv.o
  CLNG-LLC [test_maps] btf__core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr___diff_sz.o
  CLNG-LLC [test_maps] freplace_get_constant.o
  CLNG-LLC [test_maps] btf_dump_test_case_namespacing.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_ptr_type.o
  CLNG-LLC [test_maps] test_tcpbpf_kern.o
  CLNG-LLC [test_maps] bpf_iter_task.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bit_sz_change.o
  CLNG-LLC [test_maps] cg_storage_multi_shared.o
  CLNG-LLC [test_maps] fexit_bpf2bpf_simple.o
  CLNG-LLC [test_maps] metadata_used.o
  CLNG-LLC [test_maps] socket_cookie_prog.o
  CLNG-LLC [test_maps] test_subprogs.o
  CLNG-LLC [test_maps] test_core_reloc_misc.o
  CLNG-LLC [test_maps] btf_dump_test_case_multidim.o
  CLNG-LLC [test_maps] test_skb_helpers.o
  CLNG-LLC [test_maps] test_tc_edt.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_grow.o
  CLNG-LLC [test_maps] test_subprogs_unused.o
  CLNG-LLC [test_maps] test_queue_map.o
  CLNG-LLC [test_maps] test_xdp_devmap_helpers.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_func_proto.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___all_missing.o
  CLNG-LLC [test_maps] test_core_reloc_enumval.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors.o
  CLNG-LLC [test_maps] test_core_reloc_type_based.o
  CLNG-LLC [test_maps] test_stacktrace_build_id.o
  CLNG-LLC [test_maps] test_overhead.o
  CLNG-LLC [test_maps] bpf_iter_udp4.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___diff.o
  CLNG-LLC [test_maps] test_varlen.o
  CLNG-LLC [test_maps] sendmsg4_prog.o
  CLNG-LLC [test_maps] test_lwt_seg6local.o
  CLNG-LLC [test_maps] connect_force_port6.o
  CLNG-LLC [test_maps] tailcall2.o
  CLNG-LLC [test_maps] test_core_reloc_type_id.o
  CLNG-LLC [test_maps] test_pe_preserve_elems.o
  CLNG-LLC [test_maps] test_pkt_md_access.o
  CLNG-LLC [test_maps] btf_data.o
  CLNG-LLC [test_maps] test_core_autosize.o
  CLNG-LLC [test_maps] bpf_iter_sockmap.o
  CLNG-LLC [test_maps] test_sysctl_loop1.o
  CLNG-LLC [test_maps] xdp_tx.o
  CLNG-LLC [test_maps] test_xdp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___dup_compat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___just_big_enough.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_dim.o
  CLNG-LLC [test_maps] test_sk_storage_tracing.o
  CLNG-LLC [test_maps] test_map_init.o
  CLNG-LLC [test_maps] test_stack_map.o
  CLNG-LLC [test_maps] test_raw_tp_test_run.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_container.o
  CLNG-LLC [test_maps] bpf_iter_udp6.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___bool.o
  CLNG-LLC [test_maps] test_tc_tunnel.o
  CLNG-LLC [test_maps] bpf_dctcp.o
  CLNG-LLC [test_maps] test_xdp_meta.o
  CLNG-LLC [test_maps] pyperf_subprogs.o
  CLNG-LLC [test_maps] pyperf180.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bitfield_vs_int.o
  CLNG-LLC [test_maps] tailcall5.o
  CLNG-LLC [test_maps] test_sockmap_invalid_update.o
  CLNG-LLC [test_maps] test_xdp_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_field.o
  CLNG-LLC [test_maps] dev_cgroup.o
  CLNG-LLC [test_maps] btf__core_reloc_size___diff_sz.o
  CLNG-LLC [test_maps] perfbuf_bench.o
  CLNG-LLC [test_maps] bpf_iter_task_file.o
  CLNG-LLC [test_maps] sockopt_sk.o
  CLNG-LLC [test_maps] profiler3.o
  CLNG-LLC [test_maps] freplace_attach_probe.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives.o
  CLNG-LLC [test_maps] bpf_iter_test_kern3.o
  CLNG-LLC [test_maps] freplace_cls_redirect.o
  CLNG-LLC [test_maps] bpf_iter_ipv6_route.o
  CLNG-LLC [test_maps] load_bytes_relative.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___fixed_arr.o
  CLNG-LLC [test_maps] test_d_path.o
  CLNG-LLC [test_maps] btf__core_reloc_size___err_ambiguous.o
  CLNG-LLC [test_maps] test_sockhash_kern.o
  CLNG-LLC [test_maps] test_mmap.o
  CLNG-LLC [test_maps] test_lwt_ip_encap.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___mod_swap.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf4.o
  CLNG-LLC [test_maps] sockopt_inherit.o
  CLNG-LLC [test_maps] test_sock_fields.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_partial_match_dups.o
  CLNG-LLC [test_maps] test_lirc_mode2_kern.o
  CLNG-LLC [test_maps] bpf_cubic.o
  CLNG-LLC [test_maps] test_seg6_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_enum.o
  CLNG-LLC [test_maps] test_core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays.o
  CLNG-LLC [test_maps] test_tunnel_kern.o
  CLNG-LLC [test_maps] bpf_iter_tcp4.o
  CLNG-LLC [test_maps] btf_dump_test_case_bitfields.o
  CLNG-LLC [test_maps] loop3.o
  CLNG-LLC [test_maps] test_autoload.o
  CLNG-LLC [test_maps] btf__core_reloc_mods.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_probed.o
  CLNG-LLC [test_maps] test_attach_probe.o
  CLNG-LLC [test_maps] test_trace_ext_tracing.o
  CLNG-LLC [test_maps] test_ringbuf_multi.o
  CLNG-LLC [test_maps] btf__core_reloc_misc.o
  CLNG-LLC [test_maps] pyperf50.o
  CLNG-LLC [test_maps] test_btf_map_in_map.o
  CLNG-LLC [test_maps] fentry_test.o
  CLNG-LLC [test_maps] tailcall1.o
  CLNG-LLC [test_maps] test_pkt_access.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors__err_wrong_name.o
  CLNG-LLC [test_maps] test_sk_storage_trace_itself.o
  CLNG-LLC [test_maps] test_obj_id.o
  CLNG-LLC [test_maps] test_global_func3.o
  CLNG-LLC [test_maps] tcp_rtt.o
  CLNG-LLC [test_maps] test_tcpnotify_kern.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_hash_map.o
  CLNG-LLC [test_maps] kfree_skb.o
  CLNG-LLC [test_maps] btf_dump_test_case_ordering.o
  CLNG-LLC [test_maps] strobemeta_subprogs.o
  CLNG-LLC [test_maps] xdping_kern.o
  CLNG-LLC [test_maps] test_core_reloc_primitives.o
  CLNG-LLC [test_maps] cgroup_skb_sk_lookup_kern.o
  CLNG-LLC [test_maps] xdp_dummy.o
  CLNG-LLC [test_maps] strobemeta.o
  CLNG-LLC [test_maps] metadata_unused.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_type.o
  CLNG-LLC [test_maps] tailcall4.o
  CLNG-LLC [test_maps] freplace_connect4.o
  CLNG-LLC [test_maps] test_perf_branches.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___minimal.o
  CLNG-LLC [test_maps] test_core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_value_type.o
  CLNG-LLC [test_maps] test_pinning.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_wrong_val_type.o
  CLNG-LLC [test_maps] test_xdp_link.o
  CLNG-LLC [test_maps] test_spin_lock.o
  CLNG-LLC [test_maps] pyperf100.o
  CLNG-LLC [test_maps] connect4_prog.o
  CLNG-LLC [test_maps] test_btf_skc_cls_ingress.o
  CLNG-LLC [test_maps] connect6_prog.o
  CLNG-LLC [test_maps] test_core_reloc_arrays.o
  CLNG-LLC [test_maps] test_core_reloc_kernel.o
  CLNG-LLC [test_maps] netcnt_prog.o
  CLNG-LLC [test_maps] bpf_iter_bpf_map.o
  CLNG-LLC [test_maps] btf_dump_test_case_padding.o
  CLNG-LLC [test_maps] test_sk_assign.o
  CLNG-LLC [test_maps] btf_dump_test_case_syntax.o
  CLNG-LLC [test_maps] test_skb_ctx.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based.o
  CLNG-LLC [test_maps] test_tc_neigh.o
  CLNG-LLC [test_maps] test_sk_lookup.o
  CLNG-LLC [test_maps] bpf_iter_test_kern4.o
  CLNG-LLC [test_maps] bpf_flow.o
  CLNG-LLC [test_maps] test_select_reuseport_kern.o
  CLNG-LLC [test_maps] test_get_stack_rawtp_err.o
  CLNG-LLC [test_maps] test_verif_scale1.o
  CLNG-LLC [test_maps] bpf_iter_test_kern1.o
  CLNG-LLC [test_maps] test_misc_tcp_hdr_options.o
  CLNG-LLC [test_maps] test_ksyms.o
  CLNG-LLC [test_maps] test_verif_scale2.o
  CLNG-LLC [test_maps] modify_return.o
  CLNG-LLC [test_maps] test_sysctl_loop2.o
  CLNG-LLC [test_maps] test_global_func1.o
  CLNG-LLC [test_maps] perf_event_stackmap.o
  CLNG-LLC [test_maps] test_map_lock.o
  CLNG-LLC [test_maps] test_perf_buffer.o
  CLNG-LLC [test_maps] fexit_bpf2bpf.o
  CLNG-LLC [test_maps] test_global_func6.o
  CLNG-LLC [test_maps] sendmsg6_prog.o
  CLNG-LLC [test_maps] bpf_iter_task_btf.o
  CLNG-LLC [test_maps] btf__core_reloc_size.o
  CLNG-LLC [test_maps] bpf_iter_task_stack.o
  CLNG-LLC [test_maps] test_xdp_noinline.o
  CLNG-LLC [test_maps] skb_pkt_end.o
  CLNG-LLC [test_maps] profiler1.o
  CLNG-LLC [test_maps] test_sockmap_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_kind.o
  CLNG-LLC [test_maps] loop4.o
  CLNG-LLC [test_maps] strobemeta_nounroll1.o
  CLNG-LLC [test_maps] test_skb_cgroup_id_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___err_too_big_bitfield.o
  CLNG-LLC [test_maps] test_tcp_check_syncookie_kern.o
  CLNG-LLC [test_maps] test_ns_current_pid_tgid.o
  CLNG-LLC [test_maps] test_btf_haskv.o
  CLNG-LLC [test_maps] test_trampoline_count.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_bad_zero_sz_arr.o
  CLNG-LLC [test_maps] map_ptr_kern.o
  GEN-SKEL [test_progs] pyperf_global.skel.h
  GEN-SKEL [test_progs] test_global_data.skel.h
libbpf: elf: skipping unrecognized data section(9) .rodata.str1.1
  GEN-SKEL [test_progs] test_global_func8.skel.h
  GEN-SKEL [test_progs] test_ksyms_btf_null_check.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern5.skel.h
  GEN-SKEL [test_progs] test_cls_redirect_subprogs.skel.h
  GEN-SKEL [test_progs] test_core_reloc_nesting.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern2.skel.h
  GEN-SKEL [test_progs] test_cls_redirect.skel.h
  GEN-SKEL [test_progs] loop5.skel.h
  GEN-SKEL [test_progs] test_btf_newkv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map_legacy
  GEN-SKEL [test_progs] pyperf600.skel.h
  GEN-SKEL [test_progs] profiler2.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs] tailcall_bpf2bpf3.skel.h
  GEN-SKEL [test_progs] trigger_bench.skel.h
  GEN-SKEL [test_progs] test_probe_user.skel.h
  GEN-SKEL [test_progs] tailcall3.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_hash_map.skel.h
  GEN-SKEL [test_progs] test_endian.skel.h
  GEN-SKEL [test_progs] xdp_redirect_map.skel.h
  GEN-SKEL [test_progs] local_storage.skel.h
  GEN-SKEL [test_progs] test_get_stack_rawtp.skel.h
  GEN-SKEL [test_progs] test_core_reloc_ints.skel.h
  GEN-SKEL [test_progs] test_tracepoint.skel.h
  GEN-SKEL [test_progs] test_xdp_bpf2bpf.skel.h
  GEN-SKEL [test_progs] test_core_retro.skel.h
  GEN-SKEL [test_progs] test_send_signal_kern.skel.h
  GEN-SKEL [test_progs] test_tcp_estats.skel.h
  GEN-SKEL [test_progs] test_global_func2.skel.h
  GEN-SKEL [test_progs] test_hash_large_key.skel.h
  GEN-SKEL [test_progs] test_sockmap_listen.skel.h
  GEN-SKEL [test_progs] test_global_func7.skel.h
  GEN-SKEL [test_progs] test_xdp_with_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs] test_xdp_with_cpumap_helpers.skel.h
  GEN-SKEL [test_progs] udp_limit.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern6.skel.h
  GEN-SKEL [test_progs] test_core_extern.skel.h
  GEN-SKEL [test_progs] test_link_pinning.skel.h
  GEN-SKEL [test_progs] pyperf600_nounroll.skel.h
  GEN-SKEL [test_progs] test_ksyms_btf.skel.h
  GEN-SKEL [test_progs] lsm.skel.h
  GEN-SKEL [test_progs] loop2.skel.h
  GEN-SKEL [test_progs] sample_map_ret0.skel.h
  GEN-SKEL [test_progs] test_rdonly_maps.skel.h
  GEN-SKEL [test_progs] test_sk_lookup_kern.skel.h
libbpf: elf: skipping unrecognized data section(14) .rodata.str1.1
  GEN-SKEL [test_progs] test_vmlinux.skel.h
  GEN-SKEL [test_progs] test_ringbuf.skel.h
  GEN-SKEL [test_progs] sample_ret0.skel.h
  GEN-SKEL [test_progs] loop1.skel.h
  GEN-SKEL [test_progs] test_map_in_map.skel.h
  GEN-SKEL [test_progs] freplace_connect_v4_prog.skel.h
  GEN-SKEL [test_progs] test_l4lb_noinline.skel.h
  GEN-SKEL [test_progs] test_l4lb.skel.h
  GEN-SKEL [test_progs] sockopt_multi.skel.h
  GEN-SKEL [test_progs] tailcall_bpf2bpf2.skel.h
  GEN-SKEL [test_progs] test_trace_ext.skel.h
  GEN-SKEL [test_progs] test_cgroup_link.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_sk_storage_map.skel.h
  GEN-SKEL [test_progs] test_core_reloc_bitfields_direct.skel.h
  GEN-SKEL [test_progs] fmod_ret_freplace.skel.h
  GEN-SKEL [test_progs] netif_receive_skb.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs] tailcall_bpf2bpf1.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_packing.skel.h
  GEN-SKEL [test_progs] test_sockmap_update.skel.h
  GEN-SKEL [test_progs] sockmap_tcp_msg_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs] ringbuf_bench.skel.h
  GEN-SKEL [test_progs] test_verif_scale3.skel.h
  GEN-SKEL [test_progs] test_core_reloc_size.skel.h
  GEN-SKEL [test_progs] connect_force_port4.skel.h
  GEN-SKEL [test_progs] test_core_reloc_flavors.skel.h
  GEN-SKEL [test_progs] test_enable_stats.skel.h
  GEN-SKEL [test_progs] test_global_func5.skel.h
  GEN-SKEL [test_progs] get_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs] strobemeta_nounroll2.skel.h
  GEN-SKEL [test_progs] trace_printk.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_percpu_array_map.skel.h
  GEN-SKEL [test_progs] fexit_test.skel.h
  GEN-SKEL [test_progs] test_skmsg_load_helpers.skel.h
  GEN-SKEL [test_progs] bpf_iter_netlink.skel.h
  GEN-SKEL [test_progs] test_xdp_adjust_tail_shrink.skel.h
  GEN-SKEL [test_progs] test_core_reloc_mods.skel.h
  GEN-SKEL [test_progs] test_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_array_map.skel.h
  GEN-SKEL [test_progs] test_tc_neigh_fib.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_isolated.skel.h
  GEN-SKEL [test_progs] test_tc_peer.skel.h
  GEN-SKEL [test_progs] sockmap_parse_prog.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_egress_only.skel.h
  GEN-SKEL [test_progs] test_xdp_redirect.skel.h
  GEN-SKEL [test_progs] test_sysctl_prog.skel.h
  GEN-SKEL [test_progs] sockmap_verdict_prog.skel.h
  GEN-SKEL [test_progs] test_probe_read_user_str.skel.h
  GEN-SKEL [test_progs] test_xdp_vlan.skel.h
  GEN-SKEL [test_progs] bpf_iter_tcp6.skel.h
  GEN-SKEL [test_progs] test_global_func4.skel.h
  GEN-SKEL [test_progs] test_stacktrace_map.skel.h
  GEN-SKEL [test_progs] test_skeleton.skel.h
  GEN-SKEL [test_progs] test_btf_nokv.skel.h
  GEN-SKEL [test_progs] freplace_get_constant.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_namespacing.skel.h
  GEN-SKEL [test_progs] test_tcpbpf_kern.skel.h
  GEN-SKEL [test_progs] bpf_iter_task.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_shared.skel.h
  GEN-SKEL [test_progs] fexit_bpf2bpf_simple.skel.h
  GEN-SKEL [test_progs] metadata_used.skel.h
  GEN-SKEL [test_progs] socket_cookie_prog.skel.h
  GEN-SKEL [test_progs] test_subprogs.skel.h
  GEN-SKEL [test_progs] test_core_reloc_misc.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_multidim.skel.h
  GEN-SKEL [test_progs] test_skb_helpers.skel.h
  GEN-SKEL [test_progs] test_tc_edt.skel.h
  GEN-SKEL [test_progs] test_xdp_adjust_tail_grow.skel.h
  GEN-SKEL [test_progs] test_subprogs_unused.skel.h
  GEN-SKEL [test_progs] test_queue_map.skel.h
  GEN-SKEL [test_progs] test_xdp_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
  GEN-SKEL [test_progs] test_core_reloc_enumval.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
  GEN-SKEL [test_progs] test_core_reloc_type_based.skel.h
  GEN-SKEL [test_progs] test_stacktrace_build_id.skel.h
  GEN-SKEL [test_progs] test_overhead.skel.h
  GEN-SKEL [test_progs] bpf_iter_udp4.skel.h
  GEN-SKEL [test_progs] test_varlen.skel.h
  GEN-SKEL [test_progs] sendmsg4_prog.skel.h
  GEN-SKEL [test_progs] test_lwt_seg6local.skel.h
  GEN-SKEL [test_progs] connect_force_port6.skel.h
  GEN-SKEL [test_progs] tailcall2.skel.h
  GEN-SKEL [test_progs] test_core_reloc_type_id.skel.h
  GEN-SKEL [test_progs] test_pe_preserve_elems.skel.h
  GEN-SKEL [test_progs] test_pkt_md_access.skel.h
  GEN-SKEL [test_progs] btf_data.skel.h
  GEN-SKEL [test_progs] test_core_autosize.skel.h
  GEN-SKEL [test_progs] bpf_iter_sockmap.skel.h
  GEN-SKEL [test_progs] test_sysctl_loop1.skel.h
  GEN-SKEL [test_progs] xdp_tx.skel.h
  GEN-SKEL [test_progs] test_xdp.skel.h
  GEN-SKEL [test_progs] test_sk_storage_tracing.skel.h
  GEN-SKEL [test_progs] test_map_init.skel.h
  GEN-SKEL [test_progs] test_stack_map.skel.h
  GEN-SKEL [test_progs] test_raw_tp_test_run.skel.h
  GEN-SKEL [test_progs] bpf_iter_udp6.skel.h
  GEN-SKEL [test_progs] test_tc_tunnel.skel.h
  GEN-SKEL [test_progs] bpf_dctcp.skel.h
  GEN-SKEL [test_progs] test_xdp_meta.skel.h
  GEN-SKEL [test_progs] pyperf_subprogs.skel.h
  GEN-SKEL [test_progs] pyperf180.skel.h
  GEN-SKEL [test_progs] tailcall5.skel.h
  GEN-SKEL [test_progs] test_sockmap_invalid_update.skel.h
  GEN-SKEL [test_progs] test_xdp_loop.skel.h
  GEN-SKEL [test_progs] dev_cgroup.skel.h
  GEN-SKEL [test_progs] perfbuf_bench.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_file.skel.h
  GEN-SKEL [test_progs] sockopt_sk.skel.h
libbpf: elf: skipping unrecognized data section(10) .rodata.str1.1
  GEN-SKEL [test_progs] profiler3.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs] freplace_attach_probe.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern3.skel.h
  GEN-SKEL [test_progs] freplace_cls_redirect.skel.h
  GEN-SKEL [test_progs] bpf_iter_ipv6_route.skel.h
  GEN-SKEL [test_progs] load_bytes_relative.skel.h
  GEN-SKEL [test_progs] test_d_path.skel.h
  GEN-SKEL [test_progs] test_sockhash_kern.skel.h
  GEN-SKEL [test_progs] test_mmap.skel.h
  GEN-SKEL [test_progs] test_lwt_ip_encap.skel.h
  GEN-SKEL [test_progs] tailcall_bpf2bpf4.skel.h
  GEN-SKEL [test_progs] sockopt_inherit.skel.h
  GEN-SKEL [test_progs] test_sock_fields.skel.h
  GEN-SKEL [test_progs] test_lirc_mode2_kern.skel.h
  GEN-SKEL [test_progs] bpf_cubic.skel.h
  GEN-SKEL [test_progs] test_seg6_loop.skel.h
  GEN-SKEL [test_progs] test_core_reloc_ptr_as_arr.skel.h
  GEN-SKEL [test_progs] test_tunnel_kern.skel.h
libbpf: elf: skipping unrecognized data section(27) .rodata.str1.1
  GEN-SKEL [test_progs] bpf_iter_tcp4.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_bitfields.skel.h
  GEN-SKEL [test_progs] loop3.skel.h
  GEN-SKEL [test_progs] test_autoload.skel.h
  GEN-SKEL [test_progs] test_core_reloc_bitfields_probed.skel.h
  GEN-SKEL [test_progs] test_attach_probe.skel.h
  GEN-SKEL [test_progs] test_trace_ext_tracing.skel.h
  GEN-SKEL [test_progs] test_ringbuf_multi.skel.h
  GEN-SKEL [test_progs] pyperf50.skel.h
  GEN-SKEL [test_progs] test_btf_map_in_map.skel.h
  GEN-SKEL [test_progs] fentry_test.skel.h
  GEN-SKEL [test_progs] tailcall1.skel.h
  GEN-SKEL [test_progs] test_pkt_access.skel.h
  GEN-SKEL [test_progs] test_sk_storage_trace_itself.skel.h
  GEN-SKEL [test_progs] test_obj_id.skel.h
  GEN-SKEL [test_progs] test_global_func3.skel.h
  GEN-SKEL [test_progs] tcp_rtt.skel.h
  GEN-SKEL [test_progs] test_tcpnotify_kern.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_percpu_hash_map.skel.h
  GEN-SKEL [test_progs] kfree_skb.skel.h
libbpf: elf: skipping unrecognized data section(11) .rodata.str1.1
  GEN-SKEL [test_progs] btf_dump_test_case_ordering.skel.h
  GEN-SKEL [test_progs] strobemeta_subprogs.skel.h
  GEN-SKEL [test_progs] xdping_kern.skel.h
  GEN-SKEL [test_progs] test_core_reloc_primitives.skel.h
  GEN-SKEL [test_progs] cgroup_skb_sk_lookup_kern.skel.h
  GEN-SKEL [test_progs] xdp_dummy.skel.h
  GEN-SKEL [test_progs] strobemeta.skel.h
  GEN-SKEL [test_progs] metadata_unused.skel.h
  GEN-SKEL [test_progs] tailcall4.skel.h
  GEN-SKEL [test_progs] freplace_connect4.skel.h
  GEN-SKEL [test_progs] test_perf_branches.skel.h
  GEN-SKEL [test_progs] test_core_reloc_existence.skel.h
  GEN-SKEL [test_progs] test_pinning.skel.h
  GEN-SKEL [test_progs] test_xdp_link.skel.h
  GEN-SKEL [test_progs] test_spin_lock.skel.h
  GEN-SKEL [test_progs] pyperf100.skel.h
  GEN-SKEL [test_progs] connect4_prog.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
libbpf: elf: skipping unrecognized data section(8) .rodata.cst16
  GEN-SKEL [test_progs] test_btf_skc_cls_ingress.skel.h
  GEN-SKEL [test_progs] connect6_prog.skel.h
  GEN-SKEL [test_progs] test_core_reloc_arrays.skel.h
  GEN-SKEL [test_progs] test_core_reloc_kernel.skel.h
  GEN-SKEL [test_progs] netcnt_prog.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_map.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_padding.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_syntax.skel.h
  GEN-SKEL [test_progs] test_skb_ctx.skel.h
  GEN-SKEL [test_progs] test_tc_neigh.skel.h
  GEN-SKEL [test_progs] test_sk_lookup.skel.h
libbpf: elf: skipping unrecognized data section(45) .rodata.str1.1
  GEN-SKEL [test_progs] bpf_iter_test_kern4.skel.h
  GEN-SKEL [test_progs] bpf_flow.skel.h
  GEN-SKEL [test_progs] test_select_reuseport_kern.skel.h
  GEN-SKEL [test_progs] test_get_stack_rawtp_err.skel.h
  GEN-SKEL [test_progs] test_verif_scale1.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern1.skel.h
  GEN-SKEL [test_progs] test_misc_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs] test_ksyms.skel.h
  GEN-SKEL [test_progs] test_verif_scale2.skel.h
  GEN-SKEL [test_progs] modify_return.skel.h
  GEN-SKEL [test_progs] test_sysctl_loop2.skel.h
  GEN-SKEL [test_progs] test_global_func1.skel.h
  GEN-SKEL [test_progs] perf_event_stackmap.skel.h
  GEN-SKEL [test_progs] test_map_lock.skel.h
  GEN-SKEL [test_progs] test_perf_buffer.skel.h
  GEN-SKEL [test_progs] fexit_bpf2bpf.skel.h
  GEN-SKEL [test_progs] test_global_func6.skel.h
  GEN-SKEL [test_progs] sendmsg6_prog.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_btf.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_stack.skel.h
  GEN-SKEL [test_progs] test_xdp_noinline.skel.h
  GEN-SKEL [test_progs] skb_pkt_end.skel.h
  GEN-SKEL [test_progs] profiler1.skel.h
libbpf: elf: skipping unrecognized data section(22) .rodata.str1.1
  GEN-SKEL [test_progs] test_sockmap_kern.skel.h
  GEN-SKEL [test_progs] loop4.skel.h
  GEN-SKEL [test_progs] strobemeta_nounroll1.skel.h
  GEN-SKEL [test_progs] test_skb_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs] test_tcp_check_syncookie_kern.skel.h
  GEN-SKEL [test_progs] test_ns_current_pid_tgid.skel.h
  GEN-SKEL [test_progs] test_btf_haskv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map
  GEN-SKEL [test_progs] test_trampoline_count.skel.h
  GEN-SKEL [test_progs] map_ptr_kern.skel.h
  TEST-OBJ [test_maps] htab_map_batch_ops.test.o
  TEST-OBJ [test_maps] sk_storage_map.test.o
  TEST-OBJ [test_maps] array_map_batch_ops.test.o
  TEST-HDR [test_maps] tests.h
  EXT-OBJ  [test_maps] test_maps.o
  MKDIR    resolve_btfids
  HOSTCC   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep.o
  HOSTLD   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/exec-cmd.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/help.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/pager.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/parse-options.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/run-command.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/sigchain.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/subcmd-config.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd-in.o
  AR       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd.a
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/rbtree.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/zalloc.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/string.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/ctype.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/str_error_r.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/resolve_btfids-in.o
  LINK     resolve_btfids
  BINARY   test_maps
  BINARY   test_lru_map
  BINARY   test_lpm_map
  TEST-OBJ [test_progs] sockmap_listen.test.o
  TEST-OBJ [test_progs] snprintf_btf.test.o
  TEST-OBJ [test_progs] btf_split.test.o
  TEST-OBJ [test_progs] cls_redirect.test.o
  TEST-OBJ [test_progs] xdp_noinline.test.o
  TEST-OBJ [test_progs] xdp_adjust_tail.test.o
  TEST-OBJ [test_progs] reference_tracking.test.o
  TEST-OBJ [test_progs] enable_stats.test.o
  TEST-OBJ [test_progs] signal_pending.test.o
  TEST-OBJ [test_progs] stacktrace_map.test.o
  TEST-OBJ [test_progs] trampoline_count.test.o
  TEST-OBJ [test_progs] btf_map_in_map.test.o
  TEST-OBJ [test_progs] send_signal.test.o
  TEST-OBJ [test_progs] ksyms_btf.test.o
  TEST-OBJ [test_progs] cgroup_attach_override.test.o
  TEST-OBJ [test_progs] bpf_verif_scale.test.o
  TEST-OBJ [test_progs] tcpbpf_user.test.o
  TEST-OBJ [test_progs] flow_dissector_reattach.test.o
  TEST-OBJ [test_progs] fexit_bpf2bpf.test.o
  TEST-OBJ [test_progs] modify_return.test.o
  TEST-OBJ [test_progs] skeleton.test.o
  TEST-OBJ [test_progs] xdp_bpf2bpf.test.o
  TEST-OBJ [test_progs] pe_preserve_elems.test.o
  TEST-OBJ [test_progs] align.test.o
  TEST-OBJ [test_progs] pkt_md_access.test.o
  TEST-OBJ [test_progs] trace_ext.test.o
  TEST-OBJ [test_progs] xdp_cpumap_attach.test.o
  TEST-OBJ [test_progs] resolve_btfids.test.o
  TEST-OBJ [test_progs] vmlinux.test.o
  TEST-OBJ [test_progs] core_extern.test.o
  TEST-OBJ [test_progs] pkt_access.test.o
  TEST-OBJ [test_progs] tailcalls.test.o
  TEST-OBJ [test_progs] hashmap.test.o
  TEST-OBJ [test_progs] stacktrace_map_raw_tp.test.o
  TEST-OBJ [test_progs] map_ptr.test.o
  TEST-OBJ [test_progs] flow_dissector_load_bytes.test.o
  TEST-OBJ [test_progs] xdp_info.test.o
  TEST-OBJ [test_progs] tp_attach_query.test.o
  TEST-OBJ [test_progs] core_autosize.test.o
  TEST-OBJ [test_progs] perf_branches.test.o
  TEST-OBJ [test_progs] autoload.test.o
  TEST-OBJ [test_progs] section_names.test.o
  TEST-OBJ [test_progs] test_bpffs.test.o
  TEST-OBJ [test_progs] xdp_perf.test.o
  TEST-OBJ [test_progs] queue_stack_map.test.o
  TEST-OBJ [test_progs] d_path.test.o
  TEST-OBJ [test_progs] probe_user.test.o
  TEST-OBJ [test_progs] cgroup_attach_autodetach.test.o
  TEST-OBJ [test_progs] raw_tp_test_run.test.o
  TEST-OBJ [test_progs] test_skb_pkt_end.test.o
  TEST-OBJ [test_progs] fexit_stress.test.o
  TEST-OBJ [test_progs] sockopt_multi.test.o
  TEST-OBJ [test_progs] load_bytes_relative.test.o
  TEST-OBJ [test_progs] cpu_mask.test.o
  TEST-OBJ [test_progs] udp_limit.test.o
  TEST-OBJ [test_progs] sockmap_basic.test.o
  TEST-OBJ [test_progs] test_local_storage.test.o
  TEST-OBJ [test_progs] skb_helpers.test.o
  TEST-OBJ [test_progs] mmap.test.o
  TEST-OBJ [test_progs] obj_name.test.o
  TEST-OBJ [test_progs] sock_fields.test.o
  TEST-OBJ [test_progs] core_reloc.test.o
  TEST-OBJ [test_progs] l4lb_all.test.o
  TEST-OBJ [test_progs] stacktrace_build_id_nmi.test.o
  TEST-OBJ [test_progs] attach_probe.test.o
  TEST-OBJ [test_progs] probe_read_user_str.test.o
  TEST-OBJ [test_progs] perf_event_stackmap.test.o
  TEST-OBJ [test_progs] raw_tp_writable_test_run.test.o
  TEST-OBJ [test_progs] btf_skc_cls_ingress.test.o
  TEST-OBJ [test_progs] btf.test.o
  TEST-OBJ [test_progs] metadata.test.o
  TEST-OBJ [test_progs] ringbuf.test.o
  TEST-OBJ [test_progs] perf_buffer.test.o
  TEST-OBJ [test_progs] fentry_fexit.test.o
  TEST-OBJ [test_progs] ksyms.test.o
  TEST-OBJ [test_progs] fexit_test.test.o
  TEST-OBJ [test_progs] link_pinning.test.o
  TEST-OBJ [test_progs] bpf_tcp_ca.test.o
  TEST-OBJ [test_progs] ringbuf_multi.test.o
  TEST-OBJ [test_progs] btf_write.test.o
  TEST-OBJ [test_progs] trace_printk.test.o
  TEST-OBJ [test_progs] prog_run_xattr.test.o
  TEST-OBJ [test_progs] sockopt_inherit.test.o
  TEST-OBJ [test_progs] test_lsm.test.o
  TEST-OBJ [test_progs] cg_storage_multi.test.o
  TEST-OBJ [test_progs] bpf_iter.test.o
  TEST-OBJ [test_progs] task_fd_query_tp.test.o
  TEST-OBJ [test_progs] get_stack_raw_tp.test.o
  TEST-OBJ [test_progs] sockopt_sk.test.o
  TEST-OBJ [test_progs] pinning.test.o
  TEST-OBJ [test_progs] btf_endian.test.o
  TEST-OBJ [test_progs] btf_dump.test.o
  TEST-OBJ [test_progs] xdp_attach.test.o
  TEST-OBJ [test_progs] stacktrace_build_id.test.o
  TEST-OBJ [test_progs] ns_current_pid_tgid.test.o
  TEST-OBJ [test_progs] tcp_hdr_options.test.o
  TEST-OBJ [test_progs] varlen.test.o
  TEST-OBJ [test_progs] cgroup_link.test.o
  TEST-OBJ [test_progs] get_stackid_cannot_attach.test.o
  TEST-OBJ [test_progs] spinlock.test.o
  TEST-OBJ [test_progs] fentry_test.test.o
  TEST-OBJ [test_progs] task_fd_query_rawtp.test.o
  TEST-OBJ [test_progs] xdp.test.o
  TEST-OBJ [test_progs] cgroup_skb_sk_lookup.test.o
  TEST-OBJ [test_progs] test_global_funcs.test.o
  TEST-OBJ [test_progs] tcp_rtt.test.o
  TEST-OBJ [test_progs] sk_assign.test.o
  TEST-OBJ [test_progs] select_reuseport.test.o
  TEST-OBJ [test_progs] kfree_skb.test.o
  TEST-OBJ [test_progs] rdonly_maps.test.o
  TEST-OBJ [test_progs] sk_storage_tracing.test.o
  TEST-OBJ [test_progs] core_retro.test.o
  TEST-OBJ [test_progs] sk_lookup.test.o
  TEST-OBJ [test_progs] skb_ctx.test.o
  TEST-OBJ [test_progs] tcp_estats.test.o
  TEST-OBJ [test_progs] btf_dedup_split.test.o
  TEST-OBJ [test_progs] cgroup_attach_multi.test.o
  TEST-OBJ [test_progs] hash_large_key.test.o
  TEST-OBJ [test_progs] xdp_devmap_attach.test.o
  TEST-OBJ [test_progs] test_profiler.test.o
  TEST-OBJ [test_progs] raw_tp_writable_reject_nbd_invalid.test.o
  TEST-OBJ [test_progs] test_overhead.test.o
  TEST-OBJ [test_progs] flow_dissector.test.o
  TEST-OBJ [test_progs] sockmap_ktls.test.o
  TEST-OBJ [test_progs] xdp_link.test.o
  TEST-OBJ [test_progs] global_data_init.test.o
  TEST-OBJ [test_progs] connect_force_port.test.o
  TEST-OBJ [test_progs] map_init.test.o
  TEST-OBJ [test_progs] sockopt.test.o
  TEST-OBJ [test_progs] global_data.test.o
  TEST-OBJ [test_progs] send_signal_sched_switch.test.o
  TEST-OBJ [test_progs] map_lock.test.o
  TEST-OBJ [test_progs] endian.test.o
  TEST-OBJ [test_progs] subprogs.test.o
  TEST-OBJ [test_progs] bpf_obj_id.test.o
  TEST-HDR [test_progs] tests.h
  EXT-OBJ  [test_progs] test_progs.o
  EXT-OBJ  [test_progs] cgroup_helpers.o
  EXT-OBJ  [test_progs] trace_helpers.o
  EXT-OBJ  [test_progs] network_helpers.o
  EXT-OBJ  [test_progs] testing_helpers.o
  EXT-OBJ  [test_progs] btf_helpers.o
  BINARY   urandom_read
  BINARY   test_progs
  BINARY   test_verifier_log
  BINARY   test_dev_cgroup
  BINARY   test_sock
  BINARY   test_sockmap
  BINARY   get_cgroup_id_user
  BINARY   test_socket_cookie
  BINARY   test_cgroup_storage
  BINARY   test_netcnt
  BINARY   test_tcpnotify_user
  BINARY   test_sysctl
  MKDIR    no_alu32
  CLNG-LLC [test_maps] pyperf_global.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___extra_nesting.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___fn_wrong_args.o
  CLNG-LLC [test_maps] test_global_data.o
  CLNG-LLC [test_maps] test_global_func8.o
  CLNG-LLC [test_maps] test_ksyms_btf_null_check.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_container.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_sz.o
  CLNG-LLC [test_maps] bpf_iter_test_kern5.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___reverse_sign.o
  CLNG-LLC [test_maps] test_cls_redirect_subprogs.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_ptr.o
  CLNG-LLC [test_maps] test_core_reloc_nesting.o
  CLNG-LLC [test_maps] bpf_iter_test_kern2.o
  CLNG-LLC [test_maps] test_cls_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___incompat.o
  CLNG-LLC [test_maps] loop5.o
  CLNG-LLC [test_maps] test_btf_newkv.o
  CLNG-LLC [test_maps] pyperf600.o
  CLNG-LLC [test_maps] profiler2.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf3.o
  CLNG-LLC [test_maps] trigger_bench.o
  CLNG-LLC [test_maps] test_probe_user.o
  CLNG-LLC [test_maps] tailcall3.o
  CLNG-LLC [test_maps] bpf_iter_bpf_hash_map.o
  CLNG-LLC [test_maps] test_endian.o
  CLNG-LLC [test_maps] xdp_redirect_map.o
  CLNG-LLC [test_maps] local_storage.o
  CLNG-LLC [test_maps] test_get_stack_rawtp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___struct_union_mixup.o
  CLNG-LLC [test_maps] test_core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting.o
  CLNG-LLC [test_maps] test_tracepoint.o
  CLNG-LLC [test_maps] test_xdp_bpf2bpf.o
  CLNG-LLC [test_maps] test_core_retro.o
  CLNG-LLC [test_maps] test_send_signal_kern.o
  CLNG-LLC [test_maps] test_tcp_estats.o
  CLNG-LLC [test_maps] test_global_func2.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___equiv_zero_sz_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___diff_sz.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_dup_incompat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id___missing_targets.o
  CLNG-LLC [test_maps] test_hash_large_key.o
  CLNG-LLC [test_maps] test_sockmap_listen.o
  CLNG-LLC [test_maps] test_global_func7.o
  CLNG-LLC [test_maps] test_xdp_with_devmap_helpers.o
  CLNG-LLC [test_maps] test_xdp_with_cpumap_helpers.o
  CLNG-LLC [test_maps] udp_limit.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_struct_type.o
  CLNG-LLC [test_maps] bpf_iter_test_kern6.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id.o
  CLNG-LLC [test_maps] test_core_extern.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_field.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_int.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_nonstruct_container.o
  CLNG-LLC [test_maps] test_link_pinning.o
  CLNG-LLC [test_maps] pyperf600_nounroll.o
  CLNG-LLC [test_maps] test_ksyms_btf.o
  CLNG-LLC [test_maps] lsm.o
  CLNG-LLC [test_maps] loop2.o
  CLNG-LLC [test_maps] sample_map_ret0.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___err_missing.o
  CLNG-LLC [test_maps] test_rdonly_maps.o
  CLNG-LLC [test_maps] test_sk_lookup_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
  CLNG-LLC [test_maps] test_vmlinux.o
  CLNG-LLC [test_maps] test_ringbuf.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields.o
  CLNG-LLC [test_maps] sample_ret0.o
  CLNG-LLC [test_maps] loop1.o
  CLNG-LLC [test_maps] test_map_in_map.o
  CLNG-LLC [test_maps] freplace_connect_v4_prog.o
  CLNG-LLC [test_maps] test_l4lb_noinline.o
  CLNG-LLC [test_maps] test_l4lb.o
  CLNG-LLC [test_maps] sockopt_multi.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf2.o
  CLNG-LLC [test_maps] test_trace_ext.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___anon_embed.o
  CLNG-LLC [test_maps] test_cgroup_link.o
  CLNG-LLC [test_maps] bpf_iter_bpf_sk_storage_map.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_direct.o
  CLNG-LLC [test_maps] fmod_ret_freplace.o
  CLNG-LLC [test_maps] netif_receive_skb.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_non_array.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf1.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_too_deep.o
  CLNG-LLC [test_maps] test_pinning_invalid.o
  CLNG-LLC [test_maps] btf_dump_test_case_packing.o
  CLNG-LLC [test_maps] test_sockmap_update.o
  CLNG-LLC [test_maps] sockmap_tcp_msg_prog.o
  CLNG-LLC [test_maps] ringbuf_bench.o
  CLNG-LLC [test_maps] test_verif_scale3.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_shallow.o
  CLNG-LLC [test_maps] test_core_reloc_size.o
  CLNG-LLC [test_maps] connect_force_port4.o
  CLNG-LLC [test_maps] test_core_reloc_flavors.o
  CLNG-LLC [test_maps] test_enable_stats.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_enum_def.o
  CLNG-LLC [test_maps] test_global_func5.o
  CLNG-LLC [test_maps] get_cgroup_id_kern.o
  CLNG-LLC [test_maps] strobemeta_nounroll2.o
  CLNG-LLC [test_maps] trace_printk.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_array_map.o
  CLNG-LLC [test_maps] fexit_test.o
  CLNG-LLC [test_maps] test_skmsg_load_helpers.o
  CLNG-LLC [test_maps] bpf_iter_netlink.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_kind.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_shrink.o
  CLNG-LLC [test_maps] test_core_reloc_mods.o
  CLNG-LLC [test_maps] test_tcp_hdr_options.o
  CLNG-LLC [test_maps] bpf_iter_bpf_array_map.o
  CLNG-LLC [test_maps] test_tc_neigh_fib.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] cg_storage_multi_isolated.o
  CLNG-LLC [test_maps] test_tc_peer.o
  CLNG-LLC [test_maps] sockmap_parse_prog.o
  CLNG-LLC [test_maps] cg_storage_multi_egress_only.o
  CLNG-LLC [test_maps] test_xdp_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___typedefs.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___val3_missing.o
  CLNG-LLC [test_maps] test_sysctl_prog.o
  CLNG-LLC [test_maps] sockmap_verdict_prog.o
  CLNG-LLC [test_maps] test_probe_read_user_str.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_small.o
  CLNG-LLC [test_maps] test_xdp_vlan.o
  CLNG-LLC [test_maps] bpf_iter_tcp6.o
  CLNG-LLC [test_maps] test_global_func4.o
  CLNG-LLC [test_maps] test_stacktrace_map.o
  CLNG-LLC [test_maps] test_skeleton.o
  CLNG-LLC [test_maps] test_btf_nokv.o
  CLNG-LLC [test_maps] btf__core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr___diff_sz.o
  CLNG-LLC [test_maps] freplace_get_constant.o
  CLNG-LLC [test_maps] btf_dump_test_case_namespacing.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_ptr_type.o
  CLNG-LLC [test_maps] test_tcpbpf_kern.o
  CLNG-LLC [test_maps] bpf_iter_task.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bit_sz_change.o
  CLNG-LLC [test_maps] cg_storage_multi_shared.o
  CLNG-LLC [test_maps] fexit_bpf2bpf_simple.o
  CLNG-LLC [test_maps] metadata_used.o
  CLNG-LLC [test_maps] socket_cookie_prog.o
  CLNG-LLC [test_maps] test_subprogs.o
  CLNG-LLC [test_maps] test_core_reloc_misc.o
  CLNG-LLC [test_maps] btf_dump_test_case_multidim.o
  CLNG-LLC [test_maps] test_skb_helpers.o
  CLNG-LLC [test_maps] test_tc_edt.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_grow.o
  CLNG-LLC [test_maps] test_subprogs_unused.o
  CLNG-LLC [test_maps] test_queue_map.o
  CLNG-LLC [test_maps] test_xdp_devmap_helpers.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_func_proto.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___all_missing.o
  CLNG-LLC [test_maps] test_core_reloc_enumval.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors.o
  CLNG-LLC [test_maps] test_core_reloc_type_based.o
  CLNG-LLC [test_maps] test_stacktrace_build_id.o
  CLNG-LLC [test_maps] test_overhead.o
  CLNG-LLC [test_maps] bpf_iter_udp4.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___diff.o
  CLNG-LLC [test_maps] test_varlen.o
  CLNG-LLC [test_maps] sendmsg4_prog.o
  CLNG-LLC [test_maps] test_lwt_seg6local.o
  CLNG-LLC [test_maps] connect_force_port6.o
  CLNG-LLC [test_maps] tailcall2.o
  CLNG-LLC [test_maps] test_core_reloc_type_id.o
  CLNG-LLC [test_maps] test_pe_preserve_elems.o
  CLNG-LLC [test_maps] test_pkt_md_access.o
  CLNG-LLC [test_maps] btf_data.o
  CLNG-LLC [test_maps] test_core_autosize.o
  CLNG-LLC [test_maps] bpf_iter_sockmap.o
  CLNG-LLC [test_maps] test_sysctl_loop1.o
  CLNG-LLC [test_maps] xdp_tx.o
  CLNG-LLC [test_maps] test_xdp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___dup_compat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___just_big_enough.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_dim.o
  CLNG-LLC [test_maps] test_sk_storage_tracing.o
  CLNG-LLC [test_maps] test_map_init.o
  CLNG-LLC [test_maps] test_stack_map.o
  CLNG-LLC [test_maps] test_raw_tp_test_run.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_container.o
  CLNG-LLC [test_maps] bpf_iter_udp6.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___bool.o
  CLNG-LLC [test_maps] test_tc_tunnel.o
  CLNG-LLC [test_maps] bpf_dctcp.o
  CLNG-LLC [test_maps] test_xdp_meta.o
  CLNG-LLC [test_maps] pyperf_subprogs.o
  CLNG-LLC [test_maps] pyperf180.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bitfield_vs_int.o
  CLNG-LLC [test_maps] tailcall5.o
  CLNG-LLC [test_maps] test_sockmap_invalid_update.o
  CLNG-LLC [test_maps] test_xdp_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_field.o
  CLNG-LLC [test_maps] dev_cgroup.o
  CLNG-LLC [test_maps] btf__core_reloc_size___diff_sz.o
  CLNG-LLC [test_maps] perfbuf_bench.o
  CLNG-LLC [test_maps] bpf_iter_task_file.o
  CLNG-LLC [test_maps] sockopt_sk.o
  CLNG-LLC [test_maps] profiler3.o
  CLNG-LLC [test_maps] freplace_attach_probe.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives.o
  CLNG-LLC [test_maps] bpf_iter_test_kern3.o
  CLNG-LLC [test_maps] freplace_cls_redirect.o
  CLNG-LLC [test_maps] bpf_iter_ipv6_route.o
  CLNG-LLC [test_maps] load_bytes_relative.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___fixed_arr.o
  CLNG-LLC [test_maps] test_d_path.o
  CLNG-LLC [test_maps] btf__core_reloc_size___err_ambiguous.o
  CLNG-LLC [test_maps] test_sockhash_kern.o
  CLNG-LLC [test_maps] test_mmap.o
  CLNG-LLC [test_maps] test_lwt_ip_encap.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___mod_swap.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf4.o
  CLNG-LLC [test_maps] sockopt_inherit.o
  CLNG-LLC [test_maps] test_sock_fields.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_partial_match_dups.o
  CLNG-LLC [test_maps] test_lirc_mode2_kern.o
  CLNG-LLC [test_maps] bpf_cubic.o
  CLNG-LLC [test_maps] test_seg6_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_enum.o
  CLNG-LLC [test_maps] test_core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays.o
  CLNG-LLC [test_maps] test_tunnel_kern.o
  CLNG-LLC [test_maps] bpf_iter_tcp4.o
  CLNG-LLC [test_maps] btf_dump_test_case_bitfields.o
  CLNG-LLC [test_maps] loop3.o
  CLNG-LLC [test_maps] test_autoload.o
  CLNG-LLC [test_maps] btf__core_reloc_mods.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_probed.o
  CLNG-LLC [test_maps] test_attach_probe.o
  CLNG-LLC [test_maps] test_trace_ext_tracing.o
  CLNG-LLC [test_maps] test_ringbuf_multi.o
  CLNG-LLC [test_maps] btf__core_reloc_misc.o
  CLNG-LLC [test_maps] pyperf50.o
  CLNG-LLC [test_maps] test_btf_map_in_map.o
  CLNG-LLC [test_maps] fentry_test.o
  CLNG-LLC [test_maps] tailcall1.o
  CLNG-LLC [test_maps] test_pkt_access.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors__err_wrong_name.o
  CLNG-LLC [test_maps] test_sk_storage_trace_itself.o
  CLNG-LLC [test_maps] test_obj_id.o
  CLNG-LLC [test_maps] test_global_func3.o
  CLNG-LLC [test_maps] tcp_rtt.o
  CLNG-LLC [test_maps] test_tcpnotify_kern.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_hash_map.o
  CLNG-LLC [test_maps] kfree_skb.o
  CLNG-LLC [test_maps] btf_dump_test_case_ordering.o
  CLNG-LLC [test_maps] strobemeta_subprogs.o
  CLNG-LLC [test_maps] xdping_kern.o
  CLNG-LLC [test_maps] test_core_reloc_primitives.o
  CLNG-LLC [test_maps] cgroup_skb_sk_lookup_kern.o
  CLNG-LLC [test_maps] xdp_dummy.o
  CLNG-LLC [test_maps] strobemeta.o
  CLNG-LLC [test_maps] metadata_unused.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_type.o
  CLNG-LLC [test_maps] tailcall4.o
  CLNG-LLC [test_maps] freplace_connect4.o
  CLNG-LLC [test_maps] test_perf_branches.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___minimal.o
  CLNG-LLC [test_maps] test_core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_value_type.o
  CLNG-LLC [test_maps] test_pinning.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_wrong_val_type.o
  CLNG-LLC [test_maps] test_xdp_link.o
  CLNG-LLC [test_maps] test_spin_lock.o
  CLNG-LLC [test_maps] pyperf100.o
  CLNG-LLC [test_maps] connect4_prog.o
  CLNG-LLC [test_maps] test_btf_skc_cls_ingress.o
  CLNG-LLC [test_maps] connect6_prog.o
  CLNG-LLC [test_maps] test_core_reloc_arrays.o
  CLNG-LLC [test_maps] test_core_reloc_kernel.o
  CLNG-LLC [test_maps] netcnt_prog.o
  CLNG-LLC [test_maps] bpf_iter_bpf_map.o
  CLNG-LLC [test_maps] btf_dump_test_case_padding.o
  CLNG-LLC [test_maps] test_sk_assign.o
  CLNG-LLC [test_maps] btf_dump_test_case_syntax.o
  CLNG-LLC [test_maps] test_skb_ctx.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based.o
  CLNG-LLC [test_maps] test_tc_neigh.o
  CLNG-LLC [test_maps] test_sk_lookup.o
  CLNG-LLC [test_maps] bpf_iter_test_kern4.o
  CLNG-LLC [test_maps] bpf_flow.o
  CLNG-LLC [test_maps] test_select_reuseport_kern.o
  CLNG-LLC [test_maps] test_get_stack_rawtp_err.o
  CLNG-LLC [test_maps] test_verif_scale1.o
  CLNG-LLC [test_maps] bpf_iter_test_kern1.o
  CLNG-LLC [test_maps] test_misc_tcp_hdr_options.o
  CLNG-LLC [test_maps] test_ksyms.o
  CLNG-LLC [test_maps] test_verif_scale2.o
  CLNG-LLC [test_maps] modify_return.o
  CLNG-LLC [test_maps] test_sysctl_loop2.o
  CLNG-LLC [test_maps] test_global_func1.o
  CLNG-LLC [test_maps] perf_event_stackmap.o
  CLNG-LLC [test_maps] test_map_lock.o
  CLNG-LLC [test_maps] test_perf_buffer.o
  CLNG-LLC [test_maps] fexit_bpf2bpf.o
  CLNG-LLC [test_maps] test_global_func6.o
  CLNG-LLC [test_maps] sendmsg6_prog.o
  CLNG-LLC [test_maps] bpf_iter_task_btf.o
  CLNG-LLC [test_maps] btf__core_reloc_size.o
  CLNG-LLC [test_maps] bpf_iter_task_stack.o
  CLNG-LLC [test_maps] test_xdp_noinline.o
  CLNG-LLC [test_maps] skb_pkt_end.o
  CLNG-LLC [test_maps] profiler1.o
  CLNG-LLC [test_maps] test_sockmap_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_kind.o
  CLNG-LLC [test_maps] loop4.o
  CLNG-LLC [test_maps] strobemeta_nounroll1.o
  CLNG-LLC [test_maps] test_skb_cgroup_id_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___err_too_big_bitfield.o
  CLNG-LLC [test_maps] test_tcp_check_syncookie_kern.o
  CLNG-LLC [test_maps] test_ns_current_pid_tgid.o
  CLNG-LLC [test_maps] test_btf_haskv.o
  CLNG-LLC [test_maps] test_trampoline_count.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_bad_zero_sz_arr.o
  CLNG-LLC [test_maps] map_ptr_kern.o
  GEN-SKEL [test_progs-no_alu32] pyperf_global.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_data.skel.h
libbpf: elf: skipping unrecognized data section(9) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_global_func8.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ksyms_btf_null_check.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern5.skel.h
  GEN-SKEL [test_progs-no_alu32] test_cls_redirect_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_nesting.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_cls_redirect.skel.h
  GEN-SKEL [test_progs-no_alu32] loop5.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_newkv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map_legacy
  GEN-SKEL [test_progs-no_alu32] pyperf600.skel.h
  GEN-SKEL [test_progs-no_alu32] profiler2.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf3.skel.h
  GEN-SKEL [test_progs-no_alu32] trigger_bench.skel.h
  GEN-SKEL [test_progs-no_alu32] test_probe_user.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall3.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_hash_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_endian.skel.h
  GEN-SKEL [test_progs-no_alu32] xdp_redirect_map.skel.h
  GEN-SKEL [test_progs-no_alu32] local_storage.skel.h
  GEN-SKEL [test_progs-no_alu32] test_get_stack_rawtp.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_ints.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tracepoint.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_bpf2bpf.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_retro.skel.h
  GEN-SKEL [test_progs-no_alu32] test_send_signal_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcp_estats.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_hash_large_key.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockmap_listen.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func7.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_with_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_xdp_with_cpumap_helpers.skel.h
  GEN-SKEL [test_progs-no_alu32] udp_limit.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern6.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_extern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_link_pinning.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf600_nounroll.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ksyms_btf.skel.h
  GEN-SKEL [test_progs-no_alu32] lsm.skel.h
  GEN-SKEL [test_progs-no_alu32] loop2.skel.h
  GEN-SKEL [test_progs-no_alu32] sample_map_ret0.skel.h
  GEN-SKEL [test_progs-no_alu32] test_rdonly_maps.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_lookup_kern.skel.h
libbpf: elf: skipping unrecognized data section(14) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_vmlinux.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ringbuf.skel.h
  GEN-SKEL [test_progs-no_alu32] sample_ret0.skel.h
  GEN-SKEL [test_progs-no_alu32] loop1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_map_in_map.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_connect_v4_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_l4lb_noinline.skel.h
  GEN-SKEL [test_progs-no_alu32] test_l4lb.skel.h
  GEN-SKEL [test_progs-no_alu32] sockopt_multi.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_trace_ext.skel.h
  GEN-SKEL [test_progs-no_alu32] test_cgroup_link.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_sk_storage_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_bitfields_direct.skel.h
  GEN-SKEL [test_progs-no_alu32] fmod_ret_freplace.skel.h
  GEN-SKEL [test_progs-no_alu32] netif_receive_skb.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf1.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_packing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockmap_update.skel.h
  GEN-SKEL [test_progs-no_alu32] sockmap_tcp_msg_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] ringbuf_bench.skel.h
  GEN-SKEL [test_progs-no_alu32] test_verif_scale3.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_size.skel.h
  GEN-SKEL [test_progs-no_alu32] connect_force_port4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_flavors.skel.h
  GEN-SKEL [test_progs-no_alu32] test_enable_stats.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func5.skel.h
  GEN-SKEL [test_progs-no_alu32] get_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta_nounroll2.skel.h
  GEN-SKEL [test_progs-no_alu32] trace_printk.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_percpu_array_map.skel.h
  GEN-SKEL [test_progs-no_alu32] fexit_test.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skmsg_load_helpers.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_netlink.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_adjust_tail_shrink.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_mods.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_array_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_neigh_fib.skel.h
  GEN-SKEL [test_progs-no_alu32] cg_storage_multi_isolated.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_peer.skel.h
  GEN-SKEL [test_progs-no_alu32] sockmap_parse_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] cg_storage_multi_egress_only.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_redirect.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sysctl_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] sockmap_verdict_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_probe_read_user_str.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_vlan.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_tcp6.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_stacktrace_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skeleton.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_nokv.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_get_constant.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_namespacing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcpbpf_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task.skel.h
  GEN-SKEL [test_progs-no_alu32] cg_storage_multi_shared.skel.h
  GEN-SKEL [test_progs-no_alu32] fexit_bpf2bpf_simple.skel.h
  GEN-SKEL [test_progs-no_alu32] metadata_used.skel.h
  GEN-SKEL [test_progs-no_alu32] socket_cookie_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_misc.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_multidim.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skb_helpers.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_edt.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_adjust_tail_grow.skel.h
  GEN-SKEL [test_progs-no_alu32] test_subprogs_unused.skel.h
  GEN-SKEL [test_progs-no_alu32] test_queue_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_enumval.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_type_based.skel.h
  GEN-SKEL [test_progs-no_alu32] test_stacktrace_build_id.skel.h
  GEN-SKEL [test_progs-no_alu32] test_overhead.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_udp4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_varlen.skel.h
  GEN-SKEL [test_progs-no_alu32] sendmsg4_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_lwt_seg6local.skel.h
  GEN-SKEL [test_progs-no_alu32] connect_force_port6.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_type_id.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pe_preserve_elems.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pkt_md_access.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_data.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_autosize.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_sockmap.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sysctl_loop1.skel.h
  GEN-SKEL [test_progs-no_alu32] xdp_tx.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_storage_tracing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_map_init.skel.h
  GEN-SKEL [test_progs-no_alu32] test_stack_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_raw_tp_test_run.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_udp6.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_tunnel.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_dctcp.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_meta.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf180.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall5.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockmap_invalid_update.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_loop.skel.h
  GEN-SKEL [test_progs-no_alu32] dev_cgroup.skel.h
  GEN-SKEL [test_progs-no_alu32] perfbuf_bench.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task_file.skel.h
  GEN-SKEL [test_progs-no_alu32] sockopt_sk.skel.h
libbpf: elf: skipping unrecognized data section(10) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] profiler3.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] freplace_attach_probe.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern3.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_cls_redirect.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_ipv6_route.skel.h
  GEN-SKEL [test_progs-no_alu32] load_bytes_relative.skel.h
  GEN-SKEL [test_progs-no_alu32] test_d_path.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockhash_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_mmap.skel.h
  GEN-SKEL [test_progs-no_alu32] test_lwt_ip_encap.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf4.skel.h
  GEN-SKEL [test_progs-no_alu32] sockopt_inherit.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sock_fields.skel.h
  GEN-SKEL [test_progs-no_alu32] test_lirc_mode2_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_cubic.skel.h
  GEN-SKEL [test_progs-no_alu32] test_seg6_loop.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_ptr_as_arr.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tunnel_kern.skel.h
libbpf: elf: skipping unrecognized data section(27) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] bpf_iter_tcp4.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_bitfields.skel.h
  GEN-SKEL [test_progs-no_alu32] loop3.skel.h
  GEN-SKEL [test_progs-no_alu32] test_autoload.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_bitfields_probed.skel.h
  GEN-SKEL [test_progs-no_alu32] test_attach_probe.skel.h
  GEN-SKEL [test_progs-no_alu32] test_trace_ext_tracing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ringbuf_multi.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf50.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_map_in_map.skel.h
  GEN-SKEL [test_progs-no_alu32] fentry_test.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pkt_access.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_storage_trace_itself.skel.h
  GEN-SKEL [test_progs-no_alu32] test_obj_id.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func3.skel.h
  GEN-SKEL [test_progs-no_alu32] tcp_rtt.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcpnotify_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_percpu_hash_map.skel.h
  GEN-SKEL [test_progs-no_alu32] kfree_skb.skel.h
libbpf: elf: skipping unrecognized data section(11) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_ordering.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] xdping_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_primitives.skel.h
  GEN-SKEL [test_progs-no_alu32] cgroup_skb_sk_lookup_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] xdp_dummy.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta.skel.h
  GEN-SKEL [test_progs-no_alu32] metadata_unused.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall4.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_connect4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_perf_branches.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_existence.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pinning.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_link.skel.h
  GEN-SKEL [test_progs-no_alu32] test_spin_lock.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf100.skel.h
  GEN-SKEL [test_progs-no_alu32] connect4_prog.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
libbpf: elf: skipping unrecognized data section(8) .rodata.cst16
  GEN-SKEL [test_progs-no_alu32] test_btf_skc_cls_ingress.skel.h
  GEN-SKEL [test_progs-no_alu32] connect6_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_arrays.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_kernel.skel.h
  GEN-SKEL [test_progs-no_alu32] netcnt_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_map.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_padding.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_syntax.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skb_ctx.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_neigh.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_lookup.skel.h
libbpf: elf: skipping unrecognized data section(45) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern4.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_flow.skel.h
  GEN-SKEL [test_progs-no_alu32] test_select_reuseport_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_get_stack_rawtp_err.skel.h
  GEN-SKEL [test_progs-no_alu32] test_verif_scale1.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_misc_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ksyms.skel.h
  GEN-SKEL [test_progs-no_alu32] test_verif_scale2.skel.h
  GEN-SKEL [test_progs-no_alu32] modify_return.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sysctl_loop2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func1.skel.h
  GEN-SKEL [test_progs-no_alu32] perf_event_stackmap.skel.h
  GEN-SKEL [test_progs-no_alu32] test_map_lock.skel.h
  GEN-SKEL [test_progs-no_alu32] test_perf_buffer.skel.h
  GEN-SKEL [test_progs-no_alu32] fexit_bpf2bpf.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func6.skel.h
  GEN-SKEL [test_progs-no_alu32] sendmsg6_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task_btf.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task_stack.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_noinline.skel.h
  GEN-SKEL [test_progs-no_alu32] skb_pkt_end.skel.h
  GEN-SKEL [test_progs-no_alu32] profiler1.skel.h
libbpf: elf: skipping unrecognized data section(22) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_sockmap_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] loop4.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta_nounroll1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skb_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcp_check_syncookie_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ns_current_pid_tgid.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_haskv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map
  GEN-SKEL [test_progs-no_alu32] test_trampoline_count.skel.h
  GEN-SKEL [test_progs-no_alu32] map_ptr_kern.skel.h
  TEST-OBJ [test_progs-no_alu32] sockmap_listen.test.o
  TEST-OBJ [test_progs-no_alu32] snprintf_btf.test.o
  TEST-OBJ [test_progs-no_alu32] btf_split.test.o
  TEST-OBJ [test_progs-no_alu32] cls_redirect.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_noinline.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_adjust_tail.test.o
  TEST-OBJ [test_progs-no_alu32] reference_tracking.test.o
  TEST-OBJ [test_progs-no_alu32] enable_stats.test.o
  TEST-OBJ [test_progs-no_alu32] signal_pending.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_map.test.o
  TEST-OBJ [test_progs-no_alu32] trampoline_count.test.o
  TEST-OBJ [test_progs-no_alu32] btf_map_in_map.test.o
  TEST-OBJ [test_progs-no_alu32] send_signal.test.o
  TEST-OBJ [test_progs-no_alu32] ksyms_btf.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_attach_override.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_verif_scale.test.o
  TEST-OBJ [test_progs-no_alu32] tcpbpf_user.test.o
  TEST-OBJ [test_progs-no_alu32] flow_dissector_reattach.test.o
  TEST-OBJ [test_progs-no_alu32] fexit_bpf2bpf.test.o
  TEST-OBJ [test_progs-no_alu32] modify_return.test.o
  TEST-OBJ [test_progs-no_alu32] skeleton.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_bpf2bpf.test.o
  TEST-OBJ [test_progs-no_alu32] pe_preserve_elems.test.o
  TEST-OBJ [test_progs-no_alu32] align.test.o
  TEST-OBJ [test_progs-no_alu32] pkt_md_access.test.o
  TEST-OBJ [test_progs-no_alu32] trace_ext.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_cpumap_attach.test.o
  TEST-OBJ [test_progs-no_alu32] resolve_btfids.test.o
  TEST-OBJ [test_progs-no_alu32] vmlinux.test.o
  TEST-OBJ [test_progs-no_alu32] core_extern.test.o
  TEST-OBJ [test_progs-no_alu32] pkt_access.test.o
  TEST-OBJ [test_progs-no_alu32] tailcalls.test.o
  TEST-OBJ [test_progs-no_alu32] hashmap.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_map_raw_tp.test.o
  TEST-OBJ [test_progs-no_alu32] map_ptr.test.o
  TEST-OBJ [test_progs-no_alu32] flow_dissector_load_bytes.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_info.test.o
  TEST-OBJ [test_progs-no_alu32] tp_attach_query.test.o
  TEST-OBJ [test_progs-no_alu32] core_autosize.test.o
  TEST-OBJ [test_progs-no_alu32] perf_branches.test.o
  TEST-OBJ [test_progs-no_alu32] autoload.test.o
  TEST-OBJ [test_progs-no_alu32] section_names.test.o
  TEST-OBJ [test_progs-no_alu32] test_bpffs.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_perf.test.o
  TEST-OBJ [test_progs-no_alu32] queue_stack_map.test.o
  TEST-OBJ [test_progs-no_alu32] d_path.test.o
  TEST-OBJ [test_progs-no_alu32] probe_user.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_attach_autodetach.test.o
  TEST-OBJ [test_progs-no_alu32] raw_tp_test_run.test.o
  TEST-OBJ [test_progs-no_alu32] test_skb_pkt_end.test.o
  TEST-OBJ [test_progs-no_alu32] fexit_stress.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt_multi.test.o
  TEST-OBJ [test_progs-no_alu32] load_bytes_relative.test.o
  TEST-OBJ [test_progs-no_alu32] cpu_mask.test.o
  TEST-OBJ [test_progs-no_alu32] udp_limit.test.o
  TEST-OBJ [test_progs-no_alu32] sockmap_basic.test.o
  TEST-OBJ [test_progs-no_alu32] test_local_storage.test.o
  TEST-OBJ [test_progs-no_alu32] skb_helpers.test.o
  TEST-OBJ [test_progs-no_alu32] mmap.test.o
  TEST-OBJ [test_progs-no_alu32] obj_name.test.o
  TEST-OBJ [test_progs-no_alu32] sock_fields.test.o
  TEST-OBJ [test_progs-no_alu32] core_reloc.test.o
  TEST-OBJ [test_progs-no_alu32] l4lb_all.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_build_id_nmi.test.o
  TEST-OBJ [test_progs-no_alu32] attach_probe.test.o
  TEST-OBJ [test_progs-no_alu32] probe_read_user_str.test.o
  TEST-OBJ [test_progs-no_alu32] perf_event_stackmap.test.o
  TEST-OBJ [test_progs-no_alu32] raw_tp_writable_test_run.test.o
  TEST-OBJ [test_progs-no_alu32] btf_skc_cls_ingress.test.o
  TEST-OBJ [test_progs-no_alu32] btf.test.o
  TEST-OBJ [test_progs-no_alu32] metadata.test.o
  TEST-OBJ [test_progs-no_alu32] ringbuf.test.o
  TEST-OBJ [test_progs-no_alu32] perf_buffer.test.o
  TEST-OBJ [test_progs-no_alu32] fentry_fexit.test.o
  TEST-OBJ [test_progs-no_alu32] ksyms.test.o
  TEST-OBJ [test_progs-no_alu32] fexit_test.test.o
  TEST-OBJ [test_progs-no_alu32] link_pinning.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_tcp_ca.test.o
  TEST-OBJ [test_progs-no_alu32] ringbuf_multi.test.o
  TEST-OBJ [test_progs-no_alu32] btf_write.test.o
  TEST-OBJ [test_progs-no_alu32] trace_printk.test.o
  TEST-OBJ [test_progs-no_alu32] prog_run_xattr.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt_inherit.test.o
  TEST-OBJ [test_progs-no_alu32] test_lsm.test.o
  TEST-OBJ [test_progs-no_alu32] cg_storage_multi.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_iter.test.o
  TEST-OBJ [test_progs-no_alu32] task_fd_query_tp.test.o
  TEST-OBJ [test_progs-no_alu32] get_stack_raw_tp.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt_sk.test.o
  TEST-OBJ [test_progs-no_alu32] pinning.test.o
  TEST-OBJ [test_progs-no_alu32] btf_endian.test.o
  TEST-OBJ [test_progs-no_alu32] btf_dump.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_attach.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_build_id.test.o
  TEST-OBJ [test_progs-no_alu32] ns_current_pid_tgid.test.o
  TEST-OBJ [test_progs-no_alu32] tcp_hdr_options.test.o
  TEST-OBJ [test_progs-no_alu32] varlen.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_link.test.o
  TEST-OBJ [test_progs-no_alu32] get_stackid_cannot_attach.test.o
  TEST-OBJ [test_progs-no_alu32] spinlock.test.o
  TEST-OBJ [test_progs-no_alu32] fentry_test.test.o
  TEST-OBJ [test_progs-no_alu32] task_fd_query_rawtp.test.o
  TEST-OBJ [test_progs-no_alu32] xdp.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_skb_sk_lookup.test.o
  TEST-OBJ [test_progs-no_alu32] test_global_funcs.test.o
  TEST-OBJ [test_progs-no_alu32] tcp_rtt.test.o
  TEST-OBJ [test_progs-no_alu32] sk_assign.test.o
  TEST-OBJ [test_progs-no_alu32] select_reuseport.test.o
  TEST-OBJ [test_progs-no_alu32] kfree_skb.test.o
  TEST-OBJ [test_progs-no_alu32] rdonly_maps.test.o
  TEST-OBJ [test_progs-no_alu32] sk_storage_tracing.test.o
  TEST-OBJ [test_progs-no_alu32] core_retro.test.o
  TEST-OBJ [test_progs-no_alu32] sk_lookup.test.o
  TEST-OBJ [test_progs-no_alu32] skb_ctx.test.o
  TEST-OBJ [test_progs-no_alu32] tcp_estats.test.o
  TEST-OBJ [test_progs-no_alu32] btf_dedup_split.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_attach_multi.test.o
  TEST-OBJ [test_progs-no_alu32] hash_large_key.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_devmap_attach.test.o
  TEST-OBJ [test_progs-no_alu32] test_profiler.test.o
  TEST-OBJ [test_progs-no_alu32] raw_tp_writable_reject_nbd_invalid.test.o
  TEST-OBJ [test_progs-no_alu32] test_overhead.test.o
  TEST-OBJ [test_progs-no_alu32] flow_dissector.test.o
  TEST-OBJ [test_progs-no_alu32] sockmap_ktls.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_link.test.o
  TEST-OBJ [test_progs-no_alu32] global_data_init.test.o
  TEST-OBJ [test_progs-no_alu32] connect_force_port.test.o
  TEST-OBJ [test_progs-no_alu32] map_init.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt.test.o
  TEST-OBJ [test_progs-no_alu32] global_data.test.o
  TEST-OBJ [test_progs-no_alu32] send_signal_sched_switch.test.o
  TEST-OBJ [test_progs-no_alu32] map_lock.test.o
  TEST-OBJ [test_progs-no_alu32] endian.test.o
  TEST-OBJ [test_progs-no_alu32] subprogs.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_obj_id.test.o
  EXT-OBJ  [test_progs-no_alu32] test_progs.o
  EXT-OBJ  [test_progs-no_alu32] cgroup_helpers.o
  EXT-OBJ  [test_progs-no_alu32] trace_helpers.o
  EXT-OBJ  [test_progs-no_alu32] network_helpers.o
  EXT-OBJ  [test_progs-no_alu32] testing_helpers.o
  EXT-OBJ  [test_progs-no_alu32] btf_helpers.o
  EXT-COPY [test_progs-no_alu32] urandom_read btf_dump_test_case_bitfields.c btf_dump_test_case_ordering.c btf_dump_test_case_padding.c btf_dump_test_case_syntax.c btf_dump_test_case_packing.c btf_dump_test_case_namespacing.c btf_dump_test_case_multidim.c
  BINARY   test_progs-no_alu32
  BINARY   test_current_pid_tgid_new_ns
  BINARY   test_sock_addr
  BINARY   test_skb_cgroup_id_user
  BINARY   flow_dissector_load
  BINARY   test_flow_dissector
  BINARY   test_tcp_check_syncookie_user
  BINARY   test_lirc_mode2_user
  BINARY   xdping
  CXX      test_cpp
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/libbpf/
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/map_perf_ring.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/xlated_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/iter.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/tracelog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/link.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/perf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/btf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/libbpf.a
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/vmlinux.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/libbpf.a
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/profiler.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/profiler.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/prog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/btf_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/net.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/struct_ops.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/netlink_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/cgroup.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/cfg.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/map.o
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/pid_iter.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/pid_iter.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/pids.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/feature.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/jit_disasm.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/disasm.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//vmlinux.h
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower
  CC       bench.o
  CC       bench_count.o
  CC       bench_rename.o
  CC       bench_trigger.o
  CC       bench_ringbufs.o
  BINARY   bench
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf'
LKP SKIP net.l2tp.sh
2021-01-07 17:11:49 make -C ../../../tools/testing/selftests/net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net'
make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_bpf_numa.c -lnuma -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/tls
tls.c:106:2: error: unknown type name ‘u16’
  u16 tls_version;
  ^~~
tls.c:107:2: error: unknown type name ‘u16’
  u16 cipher_type;
  ^~~
tls.c: In function ‘tls_setup’:
tls.c:136:27: error: storage size of ‘tls12’ isn’t known
  union tls_crypto_context tls12;
                           ^~~~~
tls.c:150:21: error: ‘tls12_crypto_info_chacha20_poly1305’ undeclared (first use in this function)
   tls12_sz = sizeof(tls12_crypto_info_chacha20_poly1305);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tls.c:150:21: note: each undeclared identifier is reported only once for each function it appears in
tls.c:153:21: error: ‘tls12_crypto_info_aes_gcm_128’ undeclared (first use in this function)
   tls12_sz = sizeof(tls12_crypto_info_aes_gcm_128);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tls.c:136:27: warning: unused variable ‘tls12’ [-Wunused-variable]
  union tls_crypto_context tls12;
                           ^~~~~
make: *** [../lib.mk:139: /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/tls] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Oliver Sang


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc4-01243-g4f336e88a870"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=y
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_TTPCI_EEPROM=m
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_QLGE=m
# CONFIG_WIMAX is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AD9467 is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-7.6-kselftests'
	export job_origin='/cephfs/jenkins/jobs/lkp-mptcp/workspace/lkp-customers/linux/mptcp/kselftest/lkp-skl-d01/kernel-selftests-bm.yaml'
	export queue='validate'
	export testbox='lkp-skl-d01'
	export commit='4f336e88a870ecc56832154dff22853a3ca33e24'
	export branch='linus/master'
	export name='/cephfs/jenkins/jobs/lkp-mptcp/workspace/lkp-customers/linux/mptcp/kselftest/lkp-skl-d01/kernel-selftests-bm.yaml'
	export kernel_cmdline=
	export tbox_group='lkp-skl-d01'
	export submit_id='5ff738716a9e7712d26dd745'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4f336e88a870ecc56832154dff22853a3ca33e24-20210108-4818-1f6k6d5-2.yaml'
	export id='99de7249f523011142c9f79f9c8e69d3de165139'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=8
	export memory='28G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x50014ee20d26b072-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part1'
	export swap_partitions='/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part3'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part2'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export cpu_info='skylake i7-6700'
	export bios_version='1.2.8'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kconfig='CONFIG_USER_NS=y
CONFIG_BPF_SYSCALL=y
CONFIG_TEST_BPF=m
CONFIG_NUMA=y ~ ">= v5.6-rc1"
CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
CONFIG_IPV6=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_VETH=y
CONFIG_NET_IPVTI=m
CONFIG_IPV6_VTI=m
CONFIG_DUMMY=y
CONFIG_BRIDGE=y
CONFIG_VLAN_8021Q=y
CONFIG_IFB=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP_NF_NAT=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
CONFIG_NET_SCH_NETEM=y
CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
CONFIG_KALLSYMS=y'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export enqueue_time='2021-01-08 00:36:01 +0800'
	export compiler='gcc-9'
	export _id='5ff738776a9e7712d26dd746'
	export _rt='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/3'
	export scheduler_version='/lkp/lkp/.src-20210107-094228'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4f336e88a870ecc56832154dff22853a3ca33e24-20210108-4818-1f6k6d5-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6-kselftests
branch=linus/master
commit=4f336e88a870ecc56832154dff22853a3ca33e24
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/vmlinuz-5.10.0-rc4-01243-g4f336e88a870
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201231.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-cb0debfe-1_20201231.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=4
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/vmlinuz-5.10.0-rc4-01243-g4f336e88a870'
	export dequeue_time='2021-01-08 01:09:55 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4f336e88a870ecc56832154dff22853a3ca33e24-20210108-4818-1f6k6d5-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='net' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--5mCyUwZo2JvN/JJP
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
R2lPjrHEZ/sCAAAAAARZWg==

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: 8bit

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24
2021-01-07 17:07:57 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP WARN miss config CONFIG_BAREUDP= of net/config
2021-01-07 17:07:57 make -C bpf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf'
  MKDIR    include
  MKDIR    libbpf
  HOSTCC   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/fixdep.o
  HOSTLD   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/fixdep-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/fixdep
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so.0.3.0
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.pc
  INSTALL  headers
  CC       test_stub.o
  BINARY   test_verifier
  BINARY   test_tag
  MKDIR    bpftool
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/map_perf_ring.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/iter.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/tracelog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/link.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/perf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/btf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/libbpf.a
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/libbpf.a
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/profiler.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/profiler.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/prog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/net.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/struct_ops.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/netlink_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/cgroup.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/cfg.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/map.o
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/pids.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/feature.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/jit_disasm.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/disasm.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/bpftool
  INSTALL  bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-perf.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-map.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-link.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-iter.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-net.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-struct_ops.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-feature.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-prog.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-gen.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-cgroup.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpftool-btf.8
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpf-helpers.rst
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/bpftool/Documentation/bpf-helpers.7
  INSTALL  eBPF_helpers-manpage
  INSTALL  Documentation-man
  GEN      vmlinux.h
  CLNG-LLC [test_maps] pyperf_global.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___extra_nesting.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___fn_wrong_args.o
  CLNG-LLC [test_maps] test_global_data.o
  CLNG-LLC [test_maps] test_global_func8.o
  CLNG-LLC [test_maps] test_ksyms_btf_null_check.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_container.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_sz.o
  CLNG-LLC [test_maps] bpf_iter_test_kern5.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___reverse_sign.o
  CLNG-LLC [test_maps] test_cls_redirect_subprogs.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_ptr.o
  CLNG-LLC [test_maps] test_core_reloc_nesting.o
  CLNG-LLC [test_maps] bpf_iter_test_kern2.o
  CLNG-LLC [test_maps] test_cls_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___incompat.o
  CLNG-LLC [test_maps] loop5.o
  CLNG-LLC [test_maps] test_btf_newkv.o
  CLNG-LLC [test_maps] pyperf600.o
  CLNG-LLC [test_maps] profiler2.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf3.o
  CLNG-LLC [test_maps] trigger_bench.o
  CLNG-LLC [test_maps] test_probe_user.o
  CLNG-LLC [test_maps] tailcall3.o
  CLNG-LLC [test_maps] bpf_iter_bpf_hash_map.o
  CLNG-LLC [test_maps] test_endian.o
  CLNG-LLC [test_maps] xdp_redirect_map.o
  CLNG-LLC [test_maps] local_storage.o
  CLNG-LLC [test_maps] test_get_stack_rawtp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___struct_union_mixup.o
  CLNG-LLC [test_maps] test_core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting.o
  CLNG-LLC [test_maps] test_tracepoint.o
  CLNG-LLC [test_maps] test_xdp_bpf2bpf.o
  CLNG-LLC [test_maps] test_core_retro.o
  CLNG-LLC [test_maps] test_send_signal_kern.o
  CLNG-LLC [test_maps] test_tcp_estats.o
  CLNG-LLC [test_maps] test_global_func2.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___equiv_zero_sz_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___diff_sz.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_dup_incompat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id___missing_targets.o
  CLNG-LLC [test_maps] test_hash_large_key.o
  CLNG-LLC [test_maps] test_sockmap_listen.o
  CLNG-LLC [test_maps] test_global_func7.o
  CLNG-LLC [test_maps] test_xdp_with_devmap_helpers.o
  CLNG-LLC [test_maps] test_xdp_with_cpumap_helpers.o
  CLNG-LLC [test_maps] udp_limit.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_struct_type.o
  CLNG-LLC [test_maps] bpf_iter_test_kern6.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id.o
  CLNG-LLC [test_maps] test_core_extern.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_field.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_int.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_nonstruct_container.o
  CLNG-LLC [test_maps] test_link_pinning.o
  CLNG-LLC [test_maps] pyperf600_nounroll.o
  CLNG-LLC [test_maps] test_ksyms_btf.o
  CLNG-LLC [test_maps] lsm.o
  CLNG-LLC [test_maps] loop2.o
  CLNG-LLC [test_maps] sample_map_ret0.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___err_missing.o
  CLNG-LLC [test_maps] test_rdonly_maps.o
  CLNG-LLC [test_maps] test_sk_lookup_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
  CLNG-LLC [test_maps] test_vmlinux.o
  CLNG-LLC [test_maps] test_ringbuf.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields.o
  CLNG-LLC [test_maps] sample_ret0.o
  CLNG-LLC [test_maps] loop1.o
  CLNG-LLC [test_maps] test_map_in_map.o
  CLNG-LLC [test_maps] freplace_connect_v4_prog.o
  CLNG-LLC [test_maps] test_l4lb_noinline.o
  CLNG-LLC [test_maps] test_l4lb.o
  CLNG-LLC [test_maps] sockopt_multi.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf2.o
  CLNG-LLC [test_maps] test_trace_ext.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___anon_embed.o
  CLNG-LLC [test_maps] test_cgroup_link.o
  CLNG-LLC [test_maps] bpf_iter_bpf_sk_storage_map.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_direct.o
  CLNG-LLC [test_maps] fmod_ret_freplace.o
  CLNG-LLC [test_maps] netif_receive_skb.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_non_array.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf1.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_too_deep.o
  CLNG-LLC [test_maps] test_pinning_invalid.o
  CLNG-LLC [test_maps] btf_dump_test_case_packing.o
  CLNG-LLC [test_maps] test_sockmap_update.o
  CLNG-LLC [test_maps] sockmap_tcp_msg_prog.o
  CLNG-LLC [test_maps] ringbuf_bench.o
  CLNG-LLC [test_maps] test_verif_scale3.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_shallow.o
  CLNG-LLC [test_maps] test_core_reloc_size.o
  CLNG-LLC [test_maps] connect_force_port4.o
  CLNG-LLC [test_maps] test_core_reloc_flavors.o
  CLNG-LLC [test_maps] test_enable_stats.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_enum_def.o
  CLNG-LLC [test_maps] test_global_func5.o
  CLNG-LLC [test_maps] get_cgroup_id_kern.o
  CLNG-LLC [test_maps] strobemeta_nounroll2.o
  CLNG-LLC [test_maps] trace_printk.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_array_map.o
  CLNG-LLC [test_maps] fexit_test.o
  CLNG-LLC [test_maps] test_skmsg_load_helpers.o
  CLNG-LLC [test_maps] bpf_iter_netlink.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_kind.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_shrink.o
  CLNG-LLC [test_maps] test_core_reloc_mods.o
  CLNG-LLC [test_maps] test_tcp_hdr_options.o
  CLNG-LLC [test_maps] bpf_iter_bpf_array_map.o
  CLNG-LLC [test_maps] test_tc_neigh_fib.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] cg_storage_multi_isolated.o
  CLNG-LLC [test_maps] test_tc_peer.o
  CLNG-LLC [test_maps] sockmap_parse_prog.o
  CLNG-LLC [test_maps] cg_storage_multi_egress_only.o
  CLNG-LLC [test_maps] test_xdp_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___typedefs.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___val3_missing.o
  CLNG-LLC [test_maps] test_sysctl_prog.o
  CLNG-LLC [test_maps] sockmap_verdict_prog.o
  CLNG-LLC [test_maps] test_probe_read_user_str.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_small.o
  CLNG-LLC [test_maps] test_xdp_vlan.o
  CLNG-LLC [test_maps] bpf_iter_tcp6.o
  CLNG-LLC [test_maps] test_global_func4.o
  CLNG-LLC [test_maps] test_stacktrace_map.o
  CLNG-LLC [test_maps] test_skeleton.o
  CLNG-LLC [test_maps] test_btf_nokv.o
  CLNG-LLC [test_maps] btf__core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr___diff_sz.o
  CLNG-LLC [test_maps] freplace_get_constant.o
  CLNG-LLC [test_maps] btf_dump_test_case_namespacing.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_ptr_type.o
  CLNG-LLC [test_maps] test_tcpbpf_kern.o
  CLNG-LLC [test_maps] bpf_iter_task.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bit_sz_change.o
  CLNG-LLC [test_maps] cg_storage_multi_shared.o
  CLNG-LLC [test_maps] fexit_bpf2bpf_simple.o
  CLNG-LLC [test_maps] metadata_used.o
  CLNG-LLC [test_maps] socket_cookie_prog.o
  CLNG-LLC [test_maps] test_subprogs.o
  CLNG-LLC [test_maps] test_core_reloc_misc.o
  CLNG-LLC [test_maps] btf_dump_test_case_multidim.o
  CLNG-LLC [test_maps] test_skb_helpers.o
  CLNG-LLC [test_maps] test_tc_edt.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_grow.o
  CLNG-LLC [test_maps] test_subprogs_unused.o
  CLNG-LLC [test_maps] test_queue_map.o
  CLNG-LLC [test_maps] test_xdp_devmap_helpers.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_func_proto.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___all_missing.o
  CLNG-LLC [test_maps] test_core_reloc_enumval.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors.o
  CLNG-LLC [test_maps] test_core_reloc_type_based.o
  CLNG-LLC [test_maps] test_stacktrace_build_id.o
  CLNG-LLC [test_maps] test_overhead.o
  CLNG-LLC [test_maps] bpf_iter_udp4.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___diff.o
  CLNG-LLC [test_maps] test_varlen.o
  CLNG-LLC [test_maps] sendmsg4_prog.o
  CLNG-LLC [test_maps] test_lwt_seg6local.o
  CLNG-LLC [test_maps] connect_force_port6.o
  CLNG-LLC [test_maps] tailcall2.o
  CLNG-LLC [test_maps] test_core_reloc_type_id.o
  CLNG-LLC [test_maps] test_pe_preserve_elems.o
  CLNG-LLC [test_maps] test_pkt_md_access.o
  CLNG-LLC [test_maps] btf_data.o
  CLNG-LLC [test_maps] test_core_autosize.o
  CLNG-LLC [test_maps] bpf_iter_sockmap.o
  CLNG-LLC [test_maps] test_sysctl_loop1.o
  CLNG-LLC [test_maps] xdp_tx.o
  CLNG-LLC [test_maps] test_xdp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___dup_compat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___just_big_enough.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_dim.o
  CLNG-LLC [test_maps] test_sk_storage_tracing.o
  CLNG-LLC [test_maps] test_map_init.o
  CLNG-LLC [test_maps] test_stack_map.o
  CLNG-LLC [test_maps] test_raw_tp_test_run.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_container.o
  CLNG-LLC [test_maps] bpf_iter_udp6.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___bool.o
  CLNG-LLC [test_maps] test_tc_tunnel.o
  CLNG-LLC [test_maps] bpf_dctcp.o
  CLNG-LLC [test_maps] test_xdp_meta.o
  CLNG-LLC [test_maps] pyperf_subprogs.o
  CLNG-LLC [test_maps] pyperf180.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bitfield_vs_int.o
  CLNG-LLC [test_maps] tailcall5.o
  CLNG-LLC [test_maps] test_sockmap_invalid_update.o
  CLNG-LLC [test_maps] test_xdp_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_field.o
  CLNG-LLC [test_maps] dev_cgroup.o
  CLNG-LLC [test_maps] btf__core_reloc_size___diff_sz.o
  CLNG-LLC [test_maps] perfbuf_bench.o
  CLNG-LLC [test_maps] bpf_iter_task_file.o
  CLNG-LLC [test_maps] sockopt_sk.o
  CLNG-LLC [test_maps] profiler3.o
  CLNG-LLC [test_maps] freplace_attach_probe.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives.o
  CLNG-LLC [test_maps] bpf_iter_test_kern3.o
  CLNG-LLC [test_maps] freplace_cls_redirect.o
  CLNG-LLC [test_maps] bpf_iter_ipv6_route.o
  CLNG-LLC [test_maps] load_bytes_relative.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___fixed_arr.o
  CLNG-LLC [test_maps] test_d_path.o
  CLNG-LLC [test_maps] btf__core_reloc_size___err_ambiguous.o
  CLNG-LLC [test_maps] test_sockhash_kern.o
  CLNG-LLC [test_maps] test_mmap.o
  CLNG-LLC [test_maps] test_lwt_ip_encap.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___mod_swap.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf4.o
  CLNG-LLC [test_maps] sockopt_inherit.o
  CLNG-LLC [test_maps] test_sock_fields.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_partial_match_dups.o
  CLNG-LLC [test_maps] test_lirc_mode2_kern.o
  CLNG-LLC [test_maps] bpf_cubic.o
  CLNG-LLC [test_maps] test_seg6_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_enum.o
  CLNG-LLC [test_maps] test_core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays.o
  CLNG-LLC [test_maps] test_tunnel_kern.o
  CLNG-LLC [test_maps] bpf_iter_tcp4.o
  CLNG-LLC [test_maps] btf_dump_test_case_bitfields.o
  CLNG-LLC [test_maps] loop3.o
  CLNG-LLC [test_maps] test_autoload.o
  CLNG-LLC [test_maps] btf__core_reloc_mods.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_probed.o
  CLNG-LLC [test_maps] test_attach_probe.o
  CLNG-LLC [test_maps] test_trace_ext_tracing.o
  CLNG-LLC [test_maps] test_ringbuf_multi.o
  CLNG-LLC [test_maps] btf__core_reloc_misc.o
  CLNG-LLC [test_maps] pyperf50.o
  CLNG-LLC [test_maps] test_btf_map_in_map.o
  CLNG-LLC [test_maps] fentry_test.o
  CLNG-LLC [test_maps] tailcall1.o
  CLNG-LLC [test_maps] test_pkt_access.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors__err_wrong_name.o
  CLNG-LLC [test_maps] test_sk_storage_trace_itself.o
  CLNG-LLC [test_maps] test_obj_id.o
  CLNG-LLC [test_maps] test_global_func3.o
  CLNG-LLC [test_maps] tcp_rtt.o
  CLNG-LLC [test_maps] test_tcpnotify_kern.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_hash_map.o
  CLNG-LLC [test_maps] kfree_skb.o
  CLNG-LLC [test_maps] btf_dump_test_case_ordering.o
  CLNG-LLC [test_maps] strobemeta_subprogs.o
  CLNG-LLC [test_maps] xdping_kern.o
  CLNG-LLC [test_maps] test_core_reloc_primitives.o
  CLNG-LLC [test_maps] cgroup_skb_sk_lookup_kern.o
  CLNG-LLC [test_maps] xdp_dummy.o
  CLNG-LLC [test_maps] strobemeta.o
  CLNG-LLC [test_maps] metadata_unused.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_type.o
  CLNG-LLC [test_maps] tailcall4.o
  CLNG-LLC [test_maps] freplace_connect4.o
  CLNG-LLC [test_maps] test_perf_branches.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___minimal.o
  CLNG-LLC [test_maps] test_core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_value_type.o
  CLNG-LLC [test_maps] test_pinning.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_wrong_val_type.o
  CLNG-LLC [test_maps] test_xdp_link.o
  CLNG-LLC [test_maps] test_spin_lock.o
  CLNG-LLC [test_maps] pyperf100.o
  CLNG-LLC [test_maps] connect4_prog.o
  CLNG-LLC [test_maps] test_btf_skc_cls_ingress.o
  CLNG-LLC [test_maps] connect6_prog.o
  CLNG-LLC [test_maps] test_core_reloc_arrays.o
  CLNG-LLC [test_maps] test_core_reloc_kernel.o
  CLNG-LLC [test_maps] netcnt_prog.o
  CLNG-LLC [test_maps] bpf_iter_bpf_map.o
  CLNG-LLC [test_maps] btf_dump_test_case_padding.o
  CLNG-LLC [test_maps] test_sk_assign.o
  CLNG-LLC [test_maps] btf_dump_test_case_syntax.o
  CLNG-LLC [test_maps] test_skb_ctx.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based.o
  CLNG-LLC [test_maps] test_tc_neigh.o
  CLNG-LLC [test_maps] test_sk_lookup.o
  CLNG-LLC [test_maps] bpf_iter_test_kern4.o
  CLNG-LLC [test_maps] bpf_flow.o
  CLNG-LLC [test_maps] test_select_reuseport_kern.o
  CLNG-LLC [test_maps] test_get_stack_rawtp_err.o
  CLNG-LLC [test_maps] test_verif_scale1.o
  CLNG-LLC [test_maps] bpf_iter_test_kern1.o
  CLNG-LLC [test_maps] test_misc_tcp_hdr_options.o
  CLNG-LLC [test_maps] test_ksyms.o
  CLNG-LLC [test_maps] test_verif_scale2.o
  CLNG-LLC [test_maps] modify_return.o
  CLNG-LLC [test_maps] test_sysctl_loop2.o
  CLNG-LLC [test_maps] test_global_func1.o
  CLNG-LLC [test_maps] perf_event_stackmap.o
  CLNG-LLC [test_maps] test_map_lock.o
  CLNG-LLC [test_maps] test_perf_buffer.o
  CLNG-LLC [test_maps] fexit_bpf2bpf.o
  CLNG-LLC [test_maps] test_global_func6.o
  CLNG-LLC [test_maps] sendmsg6_prog.o
  CLNG-LLC [test_maps] bpf_iter_task_btf.o
  CLNG-LLC [test_maps] btf__core_reloc_size.o
  CLNG-LLC [test_maps] bpf_iter_task_stack.o
  CLNG-LLC [test_maps] test_xdp_noinline.o
  CLNG-LLC [test_maps] skb_pkt_end.o
  CLNG-LLC [test_maps] profiler1.o
  CLNG-LLC [test_maps] test_sockmap_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_kind.o
  CLNG-LLC [test_maps] loop4.o
  CLNG-LLC [test_maps] strobemeta_nounroll1.o
  CLNG-LLC [test_maps] test_skb_cgroup_id_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___err_too_big_bitfield.o
  CLNG-LLC [test_maps] test_tcp_check_syncookie_kern.o
  CLNG-LLC [test_maps] test_ns_current_pid_tgid.o
  CLNG-LLC [test_maps] test_btf_haskv.o
  CLNG-LLC [test_maps] test_trampoline_count.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_bad_zero_sz_arr.o
  CLNG-LLC [test_maps] map_ptr_kern.o
  GEN-SKEL [test_progs] pyperf_global.skel.h
  GEN-SKEL [test_progs] test_global_data.skel.h
libbpf: elf: skipping unrecognized data section(9) .rodata.str1.1
  GEN-SKEL [test_progs] test_global_func8.skel.h
  GEN-SKEL [test_progs] test_ksyms_btf_null_check.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern5.skel.h
  GEN-SKEL [test_progs] test_cls_redirect_subprogs.skel.h
  GEN-SKEL [test_progs] test_core_reloc_nesting.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern2.skel.h
  GEN-SKEL [test_progs] test_cls_redirect.skel.h
  GEN-SKEL [test_progs] loop5.skel.h
  GEN-SKEL [test_progs] test_btf_newkv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map_legacy
  GEN-SKEL [test_progs] pyperf600.skel.h
  GEN-SKEL [test_progs] profiler2.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs] tailcall_bpf2bpf3.skel.h
  GEN-SKEL [test_progs] trigger_bench.skel.h
  GEN-SKEL [test_progs] test_probe_user.skel.h
  GEN-SKEL [test_progs] tailcall3.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_hash_map.skel.h
  GEN-SKEL [test_progs] test_endian.skel.h
  GEN-SKEL [test_progs] xdp_redirect_map.skel.h
  GEN-SKEL [test_progs] local_storage.skel.h
  GEN-SKEL [test_progs] test_get_stack_rawtp.skel.h
  GEN-SKEL [test_progs] test_core_reloc_ints.skel.h
  GEN-SKEL [test_progs] test_tracepoint.skel.h
  GEN-SKEL [test_progs] test_xdp_bpf2bpf.skel.h
  GEN-SKEL [test_progs] test_core_retro.skel.h
  GEN-SKEL [test_progs] test_send_signal_kern.skel.h
  GEN-SKEL [test_progs] test_tcp_estats.skel.h
  GEN-SKEL [test_progs] test_global_func2.skel.h
  GEN-SKEL [test_progs] test_hash_large_key.skel.h
  GEN-SKEL [test_progs] test_sockmap_listen.skel.h
  GEN-SKEL [test_progs] test_global_func7.skel.h
  GEN-SKEL [test_progs] test_xdp_with_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs] test_xdp_with_cpumap_helpers.skel.h
  GEN-SKEL [test_progs] udp_limit.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern6.skel.h
  GEN-SKEL [test_progs] test_core_extern.skel.h
  GEN-SKEL [test_progs] test_link_pinning.skel.h
  GEN-SKEL [test_progs] pyperf600_nounroll.skel.h
  GEN-SKEL [test_progs] test_ksyms_btf.skel.h
  GEN-SKEL [test_progs] lsm.skel.h
  GEN-SKEL [test_progs] loop2.skel.h
  GEN-SKEL [test_progs] sample_map_ret0.skel.h
  GEN-SKEL [test_progs] test_rdonly_maps.skel.h
  GEN-SKEL [test_progs] test_sk_lookup_kern.skel.h
libbpf: elf: skipping unrecognized data section(14) .rodata.str1.1
  GEN-SKEL [test_progs] test_vmlinux.skel.h
  GEN-SKEL [test_progs] test_ringbuf.skel.h
  GEN-SKEL [test_progs] sample_ret0.skel.h
  GEN-SKEL [test_progs] loop1.skel.h
  GEN-SKEL [test_progs] test_map_in_map.skel.h
  GEN-SKEL [test_progs] freplace_connect_v4_prog.skel.h
  GEN-SKEL [test_progs] test_l4lb_noinline.skel.h
  GEN-SKEL [test_progs] test_l4lb.skel.h
  GEN-SKEL [test_progs] sockopt_multi.skel.h
  GEN-SKEL [test_progs] tailcall_bpf2bpf2.skel.h
  GEN-SKEL [test_progs] test_trace_ext.skel.h
  GEN-SKEL [test_progs] test_cgroup_link.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_sk_storage_map.skel.h
  GEN-SKEL [test_progs] test_core_reloc_bitfields_direct.skel.h
  GEN-SKEL [test_progs] fmod_ret_freplace.skel.h
  GEN-SKEL [test_progs] netif_receive_skb.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs] tailcall_bpf2bpf1.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_packing.skel.h
  GEN-SKEL [test_progs] test_sockmap_update.skel.h
  GEN-SKEL [test_progs] sockmap_tcp_msg_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs] ringbuf_bench.skel.h
  GEN-SKEL [test_progs] test_verif_scale3.skel.h
  GEN-SKEL [test_progs] test_core_reloc_size.skel.h
  GEN-SKEL [test_progs] connect_force_port4.skel.h
  GEN-SKEL [test_progs] test_core_reloc_flavors.skel.h
  GEN-SKEL [test_progs] test_enable_stats.skel.h
  GEN-SKEL [test_progs] test_global_func5.skel.h
  GEN-SKEL [test_progs] get_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs] strobemeta_nounroll2.skel.h
  GEN-SKEL [test_progs] trace_printk.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_percpu_array_map.skel.h
  GEN-SKEL [test_progs] fexit_test.skel.h
  GEN-SKEL [test_progs] test_skmsg_load_helpers.skel.h
  GEN-SKEL [test_progs] bpf_iter_netlink.skel.h
  GEN-SKEL [test_progs] test_xdp_adjust_tail_shrink.skel.h
  GEN-SKEL [test_progs] test_core_reloc_mods.skel.h
  GEN-SKEL [test_progs] test_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_array_map.skel.h
  GEN-SKEL [test_progs] test_tc_neigh_fib.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_isolated.skel.h
  GEN-SKEL [test_progs] test_tc_peer.skel.h
  GEN-SKEL [test_progs] sockmap_parse_prog.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_egress_only.skel.h
  GEN-SKEL [test_progs] test_xdp_redirect.skel.h
  GEN-SKEL [test_progs] test_sysctl_prog.skel.h
  GEN-SKEL [test_progs] sockmap_verdict_prog.skel.h
  GEN-SKEL [test_progs] test_probe_read_user_str.skel.h
  GEN-SKEL [test_progs] test_xdp_vlan.skel.h
  GEN-SKEL [test_progs] bpf_iter_tcp6.skel.h
  GEN-SKEL [test_progs] test_global_func4.skel.h
  GEN-SKEL [test_progs] test_stacktrace_map.skel.h
  GEN-SKEL [test_progs] test_skeleton.skel.h
  GEN-SKEL [test_progs] test_btf_nokv.skel.h
  GEN-SKEL [test_progs] freplace_get_constant.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_namespacing.skel.h
  GEN-SKEL [test_progs] test_tcpbpf_kern.skel.h
  GEN-SKEL [test_progs] bpf_iter_task.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_shared.skel.h
  GEN-SKEL [test_progs] fexit_bpf2bpf_simple.skel.h
  GEN-SKEL [test_progs] metadata_used.skel.h
  GEN-SKEL [test_progs] socket_cookie_prog.skel.h
  GEN-SKEL [test_progs] test_subprogs.skel.h
  GEN-SKEL [test_progs] test_core_reloc_misc.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_multidim.skel.h
  GEN-SKEL [test_progs] test_skb_helpers.skel.h
  GEN-SKEL [test_progs] test_tc_edt.skel.h
  GEN-SKEL [test_progs] test_xdp_adjust_tail_grow.skel.h
  GEN-SKEL [test_progs] test_subprogs_unused.skel.h
  GEN-SKEL [test_progs] test_queue_map.skel.h
  GEN-SKEL [test_progs] test_xdp_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
  GEN-SKEL [test_progs] test_core_reloc_enumval.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
  GEN-SKEL [test_progs] test_core_reloc_type_based.skel.h
  GEN-SKEL [test_progs] test_stacktrace_build_id.skel.h
  GEN-SKEL [test_progs] test_overhead.skel.h
  GEN-SKEL [test_progs] bpf_iter_udp4.skel.h
  GEN-SKEL [test_progs] test_varlen.skel.h
  GEN-SKEL [test_progs] sendmsg4_prog.skel.h
  GEN-SKEL [test_progs] test_lwt_seg6local.skel.h
  GEN-SKEL [test_progs] connect_force_port6.skel.h
  GEN-SKEL [test_progs] tailcall2.skel.h
  GEN-SKEL [test_progs] test_core_reloc_type_id.skel.h
  GEN-SKEL [test_progs] test_pe_preserve_elems.skel.h
  GEN-SKEL [test_progs] test_pkt_md_access.skel.h
  GEN-SKEL [test_progs] btf_data.skel.h
  GEN-SKEL [test_progs] test_core_autosize.skel.h
  GEN-SKEL [test_progs] bpf_iter_sockmap.skel.h
  GEN-SKEL [test_progs] test_sysctl_loop1.skel.h
  GEN-SKEL [test_progs] xdp_tx.skel.h
  GEN-SKEL [test_progs] test_xdp.skel.h
  GEN-SKEL [test_progs] test_sk_storage_tracing.skel.h
  GEN-SKEL [test_progs] test_map_init.skel.h
  GEN-SKEL [test_progs] test_stack_map.skel.h
  GEN-SKEL [test_progs] test_raw_tp_test_run.skel.h
  GEN-SKEL [test_progs] bpf_iter_udp6.skel.h
  GEN-SKEL [test_progs] test_tc_tunnel.skel.h
  GEN-SKEL [test_progs] bpf_dctcp.skel.h
  GEN-SKEL [test_progs] test_xdp_meta.skel.h
  GEN-SKEL [test_progs] pyperf_subprogs.skel.h
  GEN-SKEL [test_progs] pyperf180.skel.h
  GEN-SKEL [test_progs] tailcall5.skel.h
  GEN-SKEL [test_progs] test_sockmap_invalid_update.skel.h
  GEN-SKEL [test_progs] test_xdp_loop.skel.h
  GEN-SKEL [test_progs] dev_cgroup.skel.h
  GEN-SKEL [test_progs] perfbuf_bench.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_file.skel.h
  GEN-SKEL [test_progs] sockopt_sk.skel.h
libbpf: elf: skipping unrecognized data section(10) .rodata.str1.1
  GEN-SKEL [test_progs] profiler3.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs] freplace_attach_probe.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern3.skel.h
  GEN-SKEL [test_progs] freplace_cls_redirect.skel.h
  GEN-SKEL [test_progs] bpf_iter_ipv6_route.skel.h
  GEN-SKEL [test_progs] load_bytes_relative.skel.h
  GEN-SKEL [test_progs] test_d_path.skel.h
  GEN-SKEL [test_progs] test_sockhash_kern.skel.h
  GEN-SKEL [test_progs] test_mmap.skel.h
  GEN-SKEL [test_progs] test_lwt_ip_encap.skel.h
  GEN-SKEL [test_progs] tailcall_bpf2bpf4.skel.h
  GEN-SKEL [test_progs] sockopt_inherit.skel.h
  GEN-SKEL [test_progs] test_sock_fields.skel.h
  GEN-SKEL [test_progs] test_lirc_mode2_kern.skel.h
  GEN-SKEL [test_progs] bpf_cubic.skel.h
  GEN-SKEL [test_progs] test_seg6_loop.skel.h
  GEN-SKEL [test_progs] test_core_reloc_ptr_as_arr.skel.h
  GEN-SKEL [test_progs] test_tunnel_kern.skel.h
libbpf: elf: skipping unrecognized data section(27) .rodata.str1.1
  GEN-SKEL [test_progs] bpf_iter_tcp4.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_bitfields.skel.h
  GEN-SKEL [test_progs] loop3.skel.h
  GEN-SKEL [test_progs] test_autoload.skel.h
  GEN-SKEL [test_progs] test_core_reloc_bitfields_probed.skel.h
  GEN-SKEL [test_progs] test_attach_probe.skel.h
  GEN-SKEL [test_progs] test_trace_ext_tracing.skel.h
  GEN-SKEL [test_progs] test_ringbuf_multi.skel.h
  GEN-SKEL [test_progs] pyperf50.skel.h
  GEN-SKEL [test_progs] test_btf_map_in_map.skel.h
  GEN-SKEL [test_progs] fentry_test.skel.h
  GEN-SKEL [test_progs] tailcall1.skel.h
  GEN-SKEL [test_progs] test_pkt_access.skel.h
  GEN-SKEL [test_progs] test_sk_storage_trace_itself.skel.h
  GEN-SKEL [test_progs] test_obj_id.skel.h
  GEN-SKEL [test_progs] test_global_func3.skel.h
  GEN-SKEL [test_progs] tcp_rtt.skel.h
  GEN-SKEL [test_progs] test_tcpnotify_kern.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_percpu_hash_map.skel.h
  GEN-SKEL [test_progs] kfree_skb.skel.h
libbpf: elf: skipping unrecognized data section(11) .rodata.str1.1
  GEN-SKEL [test_progs] btf_dump_test_case_ordering.skel.h
  GEN-SKEL [test_progs] strobemeta_subprogs.skel.h
  GEN-SKEL [test_progs] xdping_kern.skel.h
  GEN-SKEL [test_progs] test_core_reloc_primitives.skel.h
  GEN-SKEL [test_progs] cgroup_skb_sk_lookup_kern.skel.h
  GEN-SKEL [test_progs] xdp_dummy.skel.h
  GEN-SKEL [test_progs] strobemeta.skel.h
  GEN-SKEL [test_progs] metadata_unused.skel.h
  GEN-SKEL [test_progs] tailcall4.skel.h
  GEN-SKEL [test_progs] freplace_connect4.skel.h
  GEN-SKEL [test_progs] test_perf_branches.skel.h
  GEN-SKEL [test_progs] test_core_reloc_existence.skel.h
  GEN-SKEL [test_progs] test_pinning.skel.h
  GEN-SKEL [test_progs] test_xdp_link.skel.h
  GEN-SKEL [test_progs] test_spin_lock.skel.h
  GEN-SKEL [test_progs] pyperf100.skel.h
  GEN-SKEL [test_progs] connect4_prog.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
libbpf: elf: skipping unrecognized data section(8) .rodata.cst16
  GEN-SKEL [test_progs] test_btf_skc_cls_ingress.skel.h
  GEN-SKEL [test_progs] connect6_prog.skel.h
  GEN-SKEL [test_progs] test_core_reloc_arrays.skel.h
  GEN-SKEL [test_progs] test_core_reloc_kernel.skel.h
  GEN-SKEL [test_progs] netcnt_prog.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_map.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_padding.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_syntax.skel.h
  GEN-SKEL [test_progs] test_skb_ctx.skel.h
  GEN-SKEL [test_progs] test_tc_neigh.skel.h
  GEN-SKEL [test_progs] test_sk_lookup.skel.h
libbpf: elf: skipping unrecognized data section(45) .rodata.str1.1
  GEN-SKEL [test_progs] bpf_iter_test_kern4.skel.h
  GEN-SKEL [test_progs] bpf_flow.skel.h
  GEN-SKEL [test_progs] test_select_reuseport_kern.skel.h
  GEN-SKEL [test_progs] test_get_stack_rawtp_err.skel.h
  GEN-SKEL [test_progs] test_verif_scale1.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern1.skel.h
  GEN-SKEL [test_progs] test_misc_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs] test_ksyms.skel.h
  GEN-SKEL [test_progs] test_verif_scale2.skel.h
  GEN-SKEL [test_progs] modify_return.skel.h
  GEN-SKEL [test_progs] test_sysctl_loop2.skel.h
  GEN-SKEL [test_progs] test_global_func1.skel.h
  GEN-SKEL [test_progs] perf_event_stackmap.skel.h
  GEN-SKEL [test_progs] test_map_lock.skel.h
  GEN-SKEL [test_progs] test_perf_buffer.skel.h
  GEN-SKEL [test_progs] fexit_bpf2bpf.skel.h
  GEN-SKEL [test_progs] test_global_func6.skel.h
  GEN-SKEL [test_progs] sendmsg6_prog.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_btf.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_stack.skel.h
  GEN-SKEL [test_progs] test_xdp_noinline.skel.h
  GEN-SKEL [test_progs] skb_pkt_end.skel.h
  GEN-SKEL [test_progs] profiler1.skel.h
libbpf: elf: skipping unrecognized data section(22) .rodata.str1.1
  GEN-SKEL [test_progs] test_sockmap_kern.skel.h
  GEN-SKEL [test_progs] loop4.skel.h
  GEN-SKEL [test_progs] strobemeta_nounroll1.skel.h
  GEN-SKEL [test_progs] test_skb_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs] test_tcp_check_syncookie_kern.skel.h
  GEN-SKEL [test_progs] test_ns_current_pid_tgid.skel.h
  GEN-SKEL [test_progs] test_btf_haskv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map
  GEN-SKEL [test_progs] test_trampoline_count.skel.h
  GEN-SKEL [test_progs] map_ptr_kern.skel.h
  TEST-OBJ [test_maps] htab_map_batch_ops.test.o
  TEST-OBJ [test_maps] sk_storage_map.test.o
  TEST-OBJ [test_maps] array_map_batch_ops.test.o
  TEST-HDR [test_maps] tests.h
  EXT-OBJ  [test_maps] test_maps.o
  MKDIR    resolve_btfids
  HOSTCC   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep.o
  HOSTLD   /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/fixdep
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/exec-cmd.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/help.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/pager.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/parse-options.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/run-command.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/sigchain.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/subcmd-config.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd-in.o
  AR       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/libsubcmd.a
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/rbtree.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/zalloc.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/string.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/ctype.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/str_error_r.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/build/resolve_btfids/resolve_btfids-in.o
  LINK     resolve_btfids
  BINARY   test_maps
  BINARY   test_lru_map
  BINARY   test_lpm_map
  TEST-OBJ [test_progs] sockmap_listen.test.o
  TEST-OBJ [test_progs] snprintf_btf.test.o
  TEST-OBJ [test_progs] btf_split.test.o
  TEST-OBJ [test_progs] cls_redirect.test.o
  TEST-OBJ [test_progs] xdp_noinline.test.o
  TEST-OBJ [test_progs] xdp_adjust_tail.test.o
  TEST-OBJ [test_progs] reference_tracking.test.o
  TEST-OBJ [test_progs] enable_stats.test.o
  TEST-OBJ [test_progs] signal_pending.test.o
  TEST-OBJ [test_progs] stacktrace_map.test.o
  TEST-OBJ [test_progs] trampoline_count.test.o
  TEST-OBJ [test_progs] btf_map_in_map.test.o
  TEST-OBJ [test_progs] send_signal.test.o
  TEST-OBJ [test_progs] ksyms_btf.test.o
  TEST-OBJ [test_progs] cgroup_attach_override.test.o
  TEST-OBJ [test_progs] bpf_verif_scale.test.o
  TEST-OBJ [test_progs] tcpbpf_user.test.o
  TEST-OBJ [test_progs] flow_dissector_reattach.test.o
  TEST-OBJ [test_progs] fexit_bpf2bpf.test.o
  TEST-OBJ [test_progs] modify_return.test.o
  TEST-OBJ [test_progs] skeleton.test.o
  TEST-OBJ [test_progs] xdp_bpf2bpf.test.o
  TEST-OBJ [test_progs] pe_preserve_elems.test.o
  TEST-OBJ [test_progs] align.test.o
  TEST-OBJ [test_progs] pkt_md_access.test.o
  TEST-OBJ [test_progs] trace_ext.test.o
  TEST-OBJ [test_progs] xdp_cpumap_attach.test.o
  TEST-OBJ [test_progs] resolve_btfids.test.o
  TEST-OBJ [test_progs] vmlinux.test.o
  TEST-OBJ [test_progs] core_extern.test.o
  TEST-OBJ [test_progs] pkt_access.test.o
  TEST-OBJ [test_progs] tailcalls.test.o
  TEST-OBJ [test_progs] hashmap.test.o
  TEST-OBJ [test_progs] stacktrace_map_raw_tp.test.o
  TEST-OBJ [test_progs] map_ptr.test.o
  TEST-OBJ [test_progs] flow_dissector_load_bytes.test.o
  TEST-OBJ [test_progs] xdp_info.test.o
  TEST-OBJ [test_progs] tp_attach_query.test.o
  TEST-OBJ [test_progs] core_autosize.test.o
  TEST-OBJ [test_progs] perf_branches.test.o
  TEST-OBJ [test_progs] autoload.test.o
  TEST-OBJ [test_progs] section_names.test.o
  TEST-OBJ [test_progs] test_bpffs.test.o
  TEST-OBJ [test_progs] xdp_perf.test.o
  TEST-OBJ [test_progs] queue_stack_map.test.o
  TEST-OBJ [test_progs] d_path.test.o
  TEST-OBJ [test_progs] probe_user.test.o
  TEST-OBJ [test_progs] cgroup_attach_autodetach.test.o
  TEST-OBJ [test_progs] raw_tp_test_run.test.o
  TEST-OBJ [test_progs] test_skb_pkt_end.test.o
  TEST-OBJ [test_progs] fexit_stress.test.o
  TEST-OBJ [test_progs] sockopt_multi.test.o
  TEST-OBJ [test_progs] load_bytes_relative.test.o
  TEST-OBJ [test_progs] cpu_mask.test.o
  TEST-OBJ [test_progs] udp_limit.test.o
  TEST-OBJ [test_progs] sockmap_basic.test.o
  TEST-OBJ [test_progs] test_local_storage.test.o
  TEST-OBJ [test_progs] skb_helpers.test.o
  TEST-OBJ [test_progs] mmap.test.o
  TEST-OBJ [test_progs] obj_name.test.o
  TEST-OBJ [test_progs] sock_fields.test.o
  TEST-OBJ [test_progs] core_reloc.test.o
  TEST-OBJ [test_progs] l4lb_all.test.o
  TEST-OBJ [test_progs] stacktrace_build_id_nmi.test.o
  TEST-OBJ [test_progs] attach_probe.test.o
  TEST-OBJ [test_progs] probe_read_user_str.test.o
  TEST-OBJ [test_progs] perf_event_stackmap.test.o
  TEST-OBJ [test_progs] raw_tp_writable_test_run.test.o
  TEST-OBJ [test_progs] btf_skc_cls_ingress.test.o
  TEST-OBJ [test_progs] btf.test.o
  TEST-OBJ [test_progs] metadata.test.o
  TEST-OBJ [test_progs] ringbuf.test.o
  TEST-OBJ [test_progs] perf_buffer.test.o
  TEST-OBJ [test_progs] fentry_fexit.test.o
  TEST-OBJ [test_progs] ksyms.test.o
  TEST-OBJ [test_progs] fexit_test.test.o
  TEST-OBJ [test_progs] link_pinning.test.o
  TEST-OBJ [test_progs] bpf_tcp_ca.test.o
  TEST-OBJ [test_progs] ringbuf_multi.test.o
  TEST-OBJ [test_progs] btf_write.test.o
  TEST-OBJ [test_progs] trace_printk.test.o
  TEST-OBJ [test_progs] prog_run_xattr.test.o
  TEST-OBJ [test_progs] sockopt_inherit.test.o
  TEST-OBJ [test_progs] test_lsm.test.o
  TEST-OBJ [test_progs] cg_storage_multi.test.o
  TEST-OBJ [test_progs] bpf_iter.test.o
  TEST-OBJ [test_progs] task_fd_query_tp.test.o
  TEST-OBJ [test_progs] get_stack_raw_tp.test.o
  TEST-OBJ [test_progs] sockopt_sk.test.o
  TEST-OBJ [test_progs] pinning.test.o
  TEST-OBJ [test_progs] btf_endian.test.o
  TEST-OBJ [test_progs] btf_dump.test.o
  TEST-OBJ [test_progs] xdp_attach.test.o
  TEST-OBJ [test_progs] stacktrace_build_id.test.o
  TEST-OBJ [test_progs] ns_current_pid_tgid.test.o
  TEST-OBJ [test_progs] tcp_hdr_options.test.o
  TEST-OBJ [test_progs] varlen.test.o
  TEST-OBJ [test_progs] cgroup_link.test.o
  TEST-OBJ [test_progs] get_stackid_cannot_attach.test.o
  TEST-OBJ [test_progs] spinlock.test.o
  TEST-OBJ [test_progs] fentry_test.test.o
  TEST-OBJ [test_progs] task_fd_query_rawtp.test.o
  TEST-OBJ [test_progs] xdp.test.o
  TEST-OBJ [test_progs] cgroup_skb_sk_lookup.test.o
  TEST-OBJ [test_progs] test_global_funcs.test.o
  TEST-OBJ [test_progs] tcp_rtt.test.o
  TEST-OBJ [test_progs] sk_assign.test.o
  TEST-OBJ [test_progs] select_reuseport.test.o
  TEST-OBJ [test_progs] kfree_skb.test.o
  TEST-OBJ [test_progs] rdonly_maps.test.o
  TEST-OBJ [test_progs] sk_storage_tracing.test.o
  TEST-OBJ [test_progs] core_retro.test.o
  TEST-OBJ [test_progs] sk_lookup.test.o
  TEST-OBJ [test_progs] skb_ctx.test.o
  TEST-OBJ [test_progs] tcp_estats.test.o
  TEST-OBJ [test_progs] btf_dedup_split.test.o
  TEST-OBJ [test_progs] cgroup_attach_multi.test.o
  TEST-OBJ [test_progs] hash_large_key.test.o
  TEST-OBJ [test_progs] xdp_devmap_attach.test.o
  TEST-OBJ [test_progs] test_profiler.test.o
  TEST-OBJ [test_progs] raw_tp_writable_reject_nbd_invalid.test.o
  TEST-OBJ [test_progs] test_overhead.test.o
  TEST-OBJ [test_progs] flow_dissector.test.o
  TEST-OBJ [test_progs] sockmap_ktls.test.o
  TEST-OBJ [test_progs] xdp_link.test.o
  TEST-OBJ [test_progs] global_data_init.test.o
  TEST-OBJ [test_progs] connect_force_port.test.o
  TEST-OBJ [test_progs] map_init.test.o
  TEST-OBJ [test_progs] sockopt.test.o
  TEST-OBJ [test_progs] global_data.test.o
  TEST-OBJ [test_progs] send_signal_sched_switch.test.o
  TEST-OBJ [test_progs] map_lock.test.o
  TEST-OBJ [test_progs] endian.test.o
  TEST-OBJ [test_progs] subprogs.test.o
  TEST-OBJ [test_progs] bpf_obj_id.test.o
  TEST-HDR [test_progs] tests.h
  EXT-OBJ  [test_progs] test_progs.o
  EXT-OBJ  [test_progs] cgroup_helpers.o
  EXT-OBJ  [test_progs] trace_helpers.o
  EXT-OBJ  [test_progs] network_helpers.o
  EXT-OBJ  [test_progs] testing_helpers.o
  EXT-OBJ  [test_progs] btf_helpers.o
  BINARY   urandom_read
  BINARY   test_progs
  BINARY   test_verifier_log
  BINARY   test_dev_cgroup
  BINARY   test_sock
  BINARY   test_sockmap
  BINARY   get_cgroup_id_user
  BINARY   test_socket_cookie
  BINARY   test_cgroup_storage
  BINARY   test_netcnt
  BINARY   test_tcpnotify_user
  BINARY   test_sysctl
  MKDIR    no_alu32
  CLNG-LLC [test_maps] pyperf_global.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___extra_nesting.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___fn_wrong_args.o
  CLNG-LLC [test_maps] test_global_data.o
  CLNG-LLC [test_maps] test_global_func8.o
  CLNG-LLC [test_maps] test_ksyms_btf_null_check.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_container.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_sz.o
  CLNG-LLC [test_maps] bpf_iter_test_kern5.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___reverse_sign.o
  CLNG-LLC [test_maps] test_cls_redirect_subprogs.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_ptr.o
  CLNG-LLC [test_maps] test_core_reloc_nesting.o
  CLNG-LLC [test_maps] bpf_iter_test_kern2.o
  CLNG-LLC [test_maps] test_cls_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___incompat.o
  CLNG-LLC [test_maps] loop5.o
  CLNG-LLC [test_maps] test_btf_newkv.o
  CLNG-LLC [test_maps] pyperf600.o
  CLNG-LLC [test_maps] profiler2.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf3.o
  CLNG-LLC [test_maps] trigger_bench.o
  CLNG-LLC [test_maps] test_probe_user.o
  CLNG-LLC [test_maps] tailcall3.o
  CLNG-LLC [test_maps] bpf_iter_bpf_hash_map.o
  CLNG-LLC [test_maps] test_endian.o
  CLNG-LLC [test_maps] xdp_redirect_map.o
  CLNG-LLC [test_maps] local_storage.o
  CLNG-LLC [test_maps] test_get_stack_rawtp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___struct_union_mixup.o
  CLNG-LLC [test_maps] test_core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting.o
  CLNG-LLC [test_maps] test_tracepoint.o
  CLNG-LLC [test_maps] test_xdp_bpf2bpf.o
  CLNG-LLC [test_maps] test_core_retro.o
  CLNG-LLC [test_maps] test_send_signal_kern.o
  CLNG-LLC [test_maps] test_tcp_estats.o
  CLNG-LLC [test_maps] test_global_func2.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___equiv_zero_sz_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___diff_sz.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_dup_incompat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id___missing_targets.o
  CLNG-LLC [test_maps] test_hash_large_key.o
  CLNG-LLC [test_maps] test_sockmap_listen.o
  CLNG-LLC [test_maps] test_global_func7.o
  CLNG-LLC [test_maps] test_xdp_with_devmap_helpers.o
  CLNG-LLC [test_maps] test_xdp_with_cpumap_helpers.o
  CLNG-LLC [test_maps] udp_limit.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_struct_type.o
  CLNG-LLC [test_maps] bpf_iter_test_kern6.o
  CLNG-LLC [test_maps] btf__core_reloc_type_id.o
  CLNG-LLC [test_maps] test_core_extern.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_missing_field.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_int.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_nonstruct_container.o
  CLNG-LLC [test_maps] test_link_pinning.o
  CLNG-LLC [test_maps] pyperf600_nounroll.o
  CLNG-LLC [test_maps] test_ksyms_btf.o
  CLNG-LLC [test_maps] lsm.o
  CLNG-LLC [test_maps] loop2.o
  CLNG-LLC [test_maps] sample_map_ret0.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___err_missing.o
  CLNG-LLC [test_maps] test_rdonly_maps.o
  CLNG-LLC [test_maps] test_sk_lookup_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
  CLNG-LLC [test_maps] test_vmlinux.o
  CLNG-LLC [test_maps] test_ringbuf.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields.o
  CLNG-LLC [test_maps] sample_ret0.o
  CLNG-LLC [test_maps] loop1.o
  CLNG-LLC [test_maps] test_map_in_map.o
  CLNG-LLC [test_maps] freplace_connect_v4_prog.o
  CLNG-LLC [test_maps] test_l4lb_noinline.o
  CLNG-LLC [test_maps] test_l4lb.o
  CLNG-LLC [test_maps] sockopt_multi.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf2.o
  CLNG-LLC [test_maps] test_trace_ext.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___anon_embed.o
  CLNG-LLC [test_maps] test_cgroup_link.o
  CLNG-LLC [test_maps] bpf_iter_bpf_sk_storage_map.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_direct.o
  CLNG-LLC [test_maps] fmod_ret_freplace.o
  CLNG-LLC [test_maps] netif_receive_skb.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_non_array.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf1.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_too_deep.o
  CLNG-LLC [test_maps] test_pinning_invalid.o
  CLNG-LLC [test_maps] btf_dump_test_case_packing.o
  CLNG-LLC [test_maps] test_sockmap_update.o
  CLNG-LLC [test_maps] sockmap_tcp_msg_prog.o
  CLNG-LLC [test_maps] ringbuf_bench.o
  CLNG-LLC [test_maps] test_verif_scale3.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_shallow.o
  CLNG-LLC [test_maps] test_core_reloc_size.o
  CLNG-LLC [test_maps] connect_force_port4.o
  CLNG-LLC [test_maps] test_core_reloc_flavors.o
  CLNG-LLC [test_maps] test_enable_stats.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_enum_def.o
  CLNG-LLC [test_maps] test_global_func5.o
  CLNG-LLC [test_maps] get_cgroup_id_kern.o
  CLNG-LLC [test_maps] strobemeta_nounroll2.o
  CLNG-LLC [test_maps] trace_printk.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_array_map.o
  CLNG-LLC [test_maps] fexit_test.o
  CLNG-LLC [test_maps] test_skmsg_load_helpers.o
  CLNG-LLC [test_maps] bpf_iter_netlink.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_kind.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_shrink.o
  CLNG-LLC [test_maps] test_core_reloc_mods.o
  CLNG-LLC [test_maps] test_tcp_hdr_options.o
  CLNG-LLC [test_maps] bpf_iter_bpf_array_map.o
  CLNG-LLC [test_maps] test_tc_neigh_fib.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] cg_storage_multi_isolated.o
  CLNG-LLC [test_maps] test_tc_peer.o
  CLNG-LLC [test_maps] sockmap_parse_prog.o
  CLNG-LLC [test_maps] cg_storage_multi_egress_only.o
  CLNG-LLC [test_maps] test_xdp_redirect.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___typedefs.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___val3_missing.o
  CLNG-LLC [test_maps] test_sysctl_prog.o
  CLNG-LLC [test_maps] sockmap_verdict_prog.o
  CLNG-LLC [test_maps] test_probe_read_user_str.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_too_small.o
  CLNG-LLC [test_maps] test_xdp_vlan.o
  CLNG-LLC [test_maps] bpf_iter_tcp6.o
  CLNG-LLC [test_maps] test_global_func4.o
  CLNG-LLC [test_maps] test_stacktrace_map.o
  CLNG-LLC [test_maps] test_skeleton.o
  CLNG-LLC [test_maps] test_btf_nokv.o
  CLNG-LLC [test_maps] btf__core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ptr_as_arr___diff_sz.o
  CLNG-LLC [test_maps] freplace_get_constant.o
  CLNG-LLC [test_maps] btf_dump_test_case_namespacing.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_ptr_type.o
  CLNG-LLC [test_maps] test_tcpbpf_kern.o
  CLNG-LLC [test_maps] bpf_iter_task.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bit_sz_change.o
  CLNG-LLC [test_maps] cg_storage_multi_shared.o
  CLNG-LLC [test_maps] fexit_bpf2bpf_simple.o
  CLNG-LLC [test_maps] metadata_used.o
  CLNG-LLC [test_maps] socket_cookie_prog.o
  CLNG-LLC [test_maps] test_subprogs.o
  CLNG-LLC [test_maps] test_core_reloc_misc.o
  CLNG-LLC [test_maps] btf_dump_test_case_multidim.o
  CLNG-LLC [test_maps] test_skb_helpers.o
  CLNG-LLC [test_maps] test_tc_edt.o
  CLNG-LLC [test_maps] test_xdp_adjust_tail_grow.o
  CLNG-LLC [test_maps] test_subprogs_unused.o
  CLNG-LLC [test_maps] test_queue_map.o
  CLNG-LLC [test_maps] test_xdp_devmap_helpers.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___diff_func_proto.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based___all_missing.o
  CLNG-LLC [test_maps] test_core_reloc_enumval.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors.o
  CLNG-LLC [test_maps] test_core_reloc_type_based.o
  CLNG-LLC [test_maps] test_stacktrace_build_id.o
  CLNG-LLC [test_maps] test_overhead.o
  CLNG-LLC [test_maps] bpf_iter_udp4.o
  CLNG-LLC [test_maps] btf__core_reloc_enumval___diff.o
  CLNG-LLC [test_maps] test_varlen.o
  CLNG-LLC [test_maps] sendmsg4_prog.o
  CLNG-LLC [test_maps] test_lwt_seg6local.o
  CLNG-LLC [test_maps] connect_force_port6.o
  CLNG-LLC [test_maps] tailcall2.o
  CLNG-LLC [test_maps] test_core_reloc_type_id.o
  CLNG-LLC [test_maps] test_pe_preserve_elems.o
  CLNG-LLC [test_maps] test_pkt_md_access.o
  CLNG-LLC [test_maps] btf_data.o
  CLNG-LLC [test_maps] test_core_autosize.o
  CLNG-LLC [test_maps] bpf_iter_sockmap.o
  CLNG-LLC [test_maps] test_sysctl_loop1.o
  CLNG-LLC [test_maps] xdp_tx.o
  CLNG-LLC [test_maps] test_xdp.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___dup_compat_types.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___just_big_enough.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___diff_arr_dim.o
  CLNG-LLC [test_maps] test_sk_storage_tracing.o
  CLNG-LLC [test_maps] test_map_init.o
  CLNG-LLC [test_maps] test_stack_map.o
  CLNG-LLC [test_maps] test_raw_tp_test_run.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_container.o
  CLNG-LLC [test_maps] bpf_iter_udp6.o
  CLNG-LLC [test_maps] btf__core_reloc_ints___bool.o
  CLNG-LLC [test_maps] test_tc_tunnel.o
  CLNG-LLC [test_maps] bpf_dctcp.o
  CLNG-LLC [test_maps] test_xdp_meta.o
  CLNG-LLC [test_maps] pyperf_subprogs.o
  CLNG-LLC [test_maps] pyperf180.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___bitfield_vs_int.o
  CLNG-LLC [test_maps] tailcall5.o
  CLNG-LLC [test_maps] test_sockmap_invalid_update.o
  CLNG-LLC [test_maps] test_xdp_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_array_field.o
  CLNG-LLC [test_maps] dev_cgroup.o
  CLNG-LLC [test_maps] btf__core_reloc_size___diff_sz.o
  CLNG-LLC [test_maps] perfbuf_bench.o
  CLNG-LLC [test_maps] bpf_iter_task_file.o
  CLNG-LLC [test_maps] sockopt_sk.o
  CLNG-LLC [test_maps] profiler3.o
  CLNG-LLC [test_maps] freplace_attach_probe.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives.o
  CLNG-LLC [test_maps] bpf_iter_test_kern3.o
  CLNG-LLC [test_maps] freplace_cls_redirect.o
  CLNG-LLC [test_maps] bpf_iter_ipv6_route.o
  CLNG-LLC [test_maps] load_bytes_relative.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___fixed_arr.o
  CLNG-LLC [test_maps] test_d_path.o
  CLNG-LLC [test_maps] btf__core_reloc_size___err_ambiguous.o
  CLNG-LLC [test_maps] test_sockhash_kern.o
  CLNG-LLC [test_maps] test_mmap.o
  CLNG-LLC [test_maps] test_lwt_ip_encap.o
  CLNG-LLC [test_maps] btf__core_reloc_mods___mod_swap.o
  CLNG-LLC [test_maps] tailcall_bpf2bpf4.o
  CLNG-LLC [test_maps] sockopt_inherit.o
  CLNG-LLC [test_maps] test_sock_fields.o
  CLNG-LLC [test_maps] btf__core_reloc_nesting___err_partial_match_dups.o
  CLNG-LLC [test_maps] test_lirc_mode2_kern.o
  CLNG-LLC [test_maps] bpf_cubic.o
  CLNG-LLC [test_maps] test_seg6_loop.o
  CLNG-LLC [test_maps] btf__core_reloc_primitives___err_non_enum.o
  CLNG-LLC [test_maps] test_core_reloc_ptr_as_arr.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays.o
  CLNG-LLC [test_maps] test_tunnel_kern.o
  CLNG-LLC [test_maps] bpf_iter_tcp4.o
  CLNG-LLC [test_maps] btf_dump_test_case_bitfields.o
  CLNG-LLC [test_maps] loop3.o
  CLNG-LLC [test_maps] test_autoload.o
  CLNG-LLC [test_maps] btf__core_reloc_mods.o
  CLNG-LLC [test_maps] test_core_reloc_bitfields_probed.o
  CLNG-LLC [test_maps] test_attach_probe.o
  CLNG-LLC [test_maps] test_trace_ext_tracing.o
  CLNG-LLC [test_maps] test_ringbuf_multi.o
  CLNG-LLC [test_maps] btf__core_reloc_misc.o
  CLNG-LLC [test_maps] pyperf50.o
  CLNG-LLC [test_maps] test_btf_map_in_map.o
  CLNG-LLC [test_maps] fentry_test.o
  CLNG-LLC [test_maps] tailcall1.o
  CLNG-LLC [test_maps] test_pkt_access.o
  CLNG-LLC [test_maps] btf__core_reloc_flavors__err_wrong_name.o
  CLNG-LLC [test_maps] test_sk_storage_trace_itself.o
  CLNG-LLC [test_maps] test_obj_id.o
  CLNG-LLC [test_maps] test_global_func3.o
  CLNG-LLC [test_maps] tcp_rtt.o
  CLNG-LLC [test_maps] test_tcpnotify_kern.o
  CLNG-LLC [test_maps] bpf_iter_bpf_percpu_hash_map.o
  CLNG-LLC [test_maps] kfree_skb.o
  CLNG-LLC [test_maps] btf_dump_test_case_ordering.o
  CLNG-LLC [test_maps] strobemeta_subprogs.o
  CLNG-LLC [test_maps] xdping_kern.o
  CLNG-LLC [test_maps] test_core_reloc_primitives.o
  CLNG-LLC [test_maps] cgroup_skb_sk_lookup_kern.o
  CLNG-LLC [test_maps] xdp_dummy.o
  CLNG-LLC [test_maps] strobemeta.o
  CLNG-LLC [test_maps] metadata_unused.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_int_type.o
  CLNG-LLC [test_maps] tailcall4.o
  CLNG-LLC [test_maps] freplace_connect4.o
  CLNG-LLC [test_maps] test_perf_branches.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___minimal.o
  CLNG-LLC [test_maps] test_core_reloc_existence.o
  CLNG-LLC [test_maps] btf__core_reloc_ints.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_value_type.o
  CLNG-LLC [test_maps] test_pinning.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_wrong_val_type.o
  CLNG-LLC [test_maps] test_xdp_link.o
  CLNG-LLC [test_maps] test_spin_lock.o
  CLNG-LLC [test_maps] pyperf100.o
  CLNG-LLC [test_maps] connect4_prog.o
  CLNG-LLC [test_maps] test_btf_skc_cls_ingress.o
  CLNG-LLC [test_maps] connect6_prog.o
  CLNG-LLC [test_maps] test_core_reloc_arrays.o
  CLNG-LLC [test_maps] test_core_reloc_kernel.o
  CLNG-LLC [test_maps] netcnt_prog.o
  CLNG-LLC [test_maps] bpf_iter_bpf_map.o
  CLNG-LLC [test_maps] btf_dump_test_case_padding.o
  CLNG-LLC [test_maps] test_sk_assign.o
  CLNG-LLC [test_maps] btf_dump_test_case_syntax.o
  CLNG-LLC [test_maps] test_skb_ctx.o
  CLNG-LLC [test_maps] btf__core_reloc_type_based.o
  CLNG-LLC [test_maps] test_tc_neigh.o
  CLNG-LLC [test_maps] test_sk_lookup.o
  CLNG-LLC [test_maps] bpf_iter_test_kern4.o
  CLNG-LLC [test_maps] bpf_flow.o
  CLNG-LLC [test_maps] test_select_reuseport_kern.o
  CLNG-LLC [test_maps] test_get_stack_rawtp_err.o
  CLNG-LLC [test_maps] test_verif_scale1.o
  CLNG-LLC [test_maps] bpf_iter_test_kern1.o
  CLNG-LLC [test_maps] test_misc_tcp_hdr_options.o
  CLNG-LLC [test_maps] test_ksyms.o
  CLNG-LLC [test_maps] test_verif_scale2.o
  CLNG-LLC [test_maps] modify_return.o
  CLNG-LLC [test_maps] test_sysctl_loop2.o
  CLNG-LLC [test_maps] test_global_func1.o
  CLNG-LLC [test_maps] perf_event_stackmap.o
  CLNG-LLC [test_maps] test_map_lock.o
  CLNG-LLC [test_maps] test_perf_buffer.o
  CLNG-LLC [test_maps] fexit_bpf2bpf.o
  CLNG-LLC [test_maps] test_global_func6.o
  CLNG-LLC [test_maps] sendmsg6_prog.o
  CLNG-LLC [test_maps] bpf_iter_task_btf.o
  CLNG-LLC [test_maps] btf__core_reloc_size.o
  CLNG-LLC [test_maps] bpf_iter_task_stack.o
  CLNG-LLC [test_maps] test_xdp_noinline.o
  CLNG-LLC [test_maps] skb_pkt_end.o
  CLNG-LLC [test_maps] profiler1.o
  CLNG-LLC [test_maps] test_sockmap_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_existence___err_wrong_arr_kind.o
  CLNG-LLC [test_maps] loop4.o
  CLNG-LLC [test_maps] strobemeta_nounroll1.o
  CLNG-LLC [test_maps] test_skb_cgroup_id_kern.o
  CLNG-LLC [test_maps] btf__core_reloc_bitfields___err_too_big_bitfield.o
  CLNG-LLC [test_maps] test_tcp_check_syncookie_kern.o
  CLNG-LLC [test_maps] test_ns_current_pid_tgid.o
  CLNG-LLC [test_maps] test_btf_haskv.o
  CLNG-LLC [test_maps] test_trampoline_count.o
  CLNG-LLC [test_maps] btf__core_reloc_arrays___err_bad_zero_sz_arr.o
  CLNG-LLC [test_maps] map_ptr_kern.o
  GEN-SKEL [test_progs-no_alu32] pyperf_global.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_data.skel.h
libbpf: elf: skipping unrecognized data section(9) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_global_func8.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ksyms_btf_null_check.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern5.skel.h
  GEN-SKEL [test_progs-no_alu32] test_cls_redirect_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_nesting.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_cls_redirect.skel.h
  GEN-SKEL [test_progs-no_alu32] loop5.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_newkv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map_legacy
  GEN-SKEL [test_progs-no_alu32] pyperf600.skel.h
  GEN-SKEL [test_progs-no_alu32] profiler2.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf3.skel.h
  GEN-SKEL [test_progs-no_alu32] trigger_bench.skel.h
  GEN-SKEL [test_progs-no_alu32] test_probe_user.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall3.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_hash_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_endian.skel.h
  GEN-SKEL [test_progs-no_alu32] xdp_redirect_map.skel.h
  GEN-SKEL [test_progs-no_alu32] local_storage.skel.h
  GEN-SKEL [test_progs-no_alu32] test_get_stack_rawtp.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_ints.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tracepoint.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_bpf2bpf.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_retro.skel.h
  GEN-SKEL [test_progs-no_alu32] test_send_signal_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcp_estats.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_hash_large_key.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockmap_listen.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func7.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_with_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_xdp_with_cpumap_helpers.skel.h
  GEN-SKEL [test_progs-no_alu32] udp_limit.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern6.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_extern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_link_pinning.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf600_nounroll.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ksyms_btf.skel.h
  GEN-SKEL [test_progs-no_alu32] lsm.skel.h
  GEN-SKEL [test_progs-no_alu32] loop2.skel.h
  GEN-SKEL [test_progs-no_alu32] sample_map_ret0.skel.h
  GEN-SKEL [test_progs-no_alu32] test_rdonly_maps.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_lookup_kern.skel.h
libbpf: elf: skipping unrecognized data section(14) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_vmlinux.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ringbuf.skel.h
  GEN-SKEL [test_progs-no_alu32] sample_ret0.skel.h
  GEN-SKEL [test_progs-no_alu32] loop1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_map_in_map.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_connect_v4_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_l4lb_noinline.skel.h
  GEN-SKEL [test_progs-no_alu32] test_l4lb.skel.h
  GEN-SKEL [test_progs-no_alu32] sockopt_multi.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_trace_ext.skel.h
  GEN-SKEL [test_progs-no_alu32] test_cgroup_link.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_sk_storage_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_bitfields_direct.skel.h
  GEN-SKEL [test_progs-no_alu32] fmod_ret_freplace.skel.h
  GEN-SKEL [test_progs-no_alu32] netif_receive_skb.skel.h
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf1.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_packing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockmap_update.skel.h
  GEN-SKEL [test_progs-no_alu32] sockmap_tcp_msg_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] ringbuf_bench.skel.h
  GEN-SKEL [test_progs-no_alu32] test_verif_scale3.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_size.skel.h
  GEN-SKEL [test_progs-no_alu32] connect_force_port4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_flavors.skel.h
  GEN-SKEL [test_progs-no_alu32] test_enable_stats.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func5.skel.h
  GEN-SKEL [test_progs-no_alu32] get_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta_nounroll2.skel.h
  GEN-SKEL [test_progs-no_alu32] trace_printk.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_percpu_array_map.skel.h
  GEN-SKEL [test_progs-no_alu32] fexit_test.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skmsg_load_helpers.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_netlink.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_adjust_tail_shrink.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_mods.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_array_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_neigh_fib.skel.h
  GEN-SKEL [test_progs-no_alu32] cg_storage_multi_isolated.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_peer.skel.h
  GEN-SKEL [test_progs-no_alu32] sockmap_parse_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] cg_storage_multi_egress_only.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_redirect.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sysctl_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] sockmap_verdict_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_probe_read_user_str.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_vlan.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_tcp6.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_stacktrace_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skeleton.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_nokv.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_get_constant.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_namespacing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcpbpf_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task.skel.h
  GEN-SKEL [test_progs-no_alu32] cg_storage_multi_shared.skel.h
  GEN-SKEL [test_progs-no_alu32] fexit_bpf2bpf_simple.skel.h
  GEN-SKEL [test_progs-no_alu32] metadata_used.skel.h
  GEN-SKEL [test_progs-no_alu32] socket_cookie_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_misc.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_multidim.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skb_helpers.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_edt.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_adjust_tail_grow.skel.h
  GEN-SKEL [test_progs-no_alu32] test_subprogs_unused.skel.h
  GEN-SKEL [test_progs-no_alu32] test_queue_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_devmap_helpers.skel.h
libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_enumval.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_type_based.skel.h
  GEN-SKEL [test_progs-no_alu32] test_stacktrace_build_id.skel.h
  GEN-SKEL [test_progs-no_alu32] test_overhead.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_udp4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_varlen.skel.h
  GEN-SKEL [test_progs-no_alu32] sendmsg4_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_lwt_seg6local.skel.h
  GEN-SKEL [test_progs-no_alu32] connect_force_port6.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_type_id.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pe_preserve_elems.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pkt_md_access.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_data.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_autosize.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_sockmap.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sysctl_loop1.skel.h
  GEN-SKEL [test_progs-no_alu32] xdp_tx.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_storage_tracing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_map_init.skel.h
  GEN-SKEL [test_progs-no_alu32] test_stack_map.skel.h
  GEN-SKEL [test_progs-no_alu32] test_raw_tp_test_run.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_udp6.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_tunnel.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_dctcp.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_meta.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf180.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall5.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockmap_invalid_update.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_loop.skel.h
  GEN-SKEL [test_progs-no_alu32] dev_cgroup.skel.h
  GEN-SKEL [test_progs-no_alu32] perfbuf_bench.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task_file.skel.h
  GEN-SKEL [test_progs-no_alu32] sockopt_sk.skel.h
libbpf: elf: skipping unrecognized data section(10) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] profiler3.skel.h
libbpf: elf: skipping unrecognized data section(23) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] freplace_attach_probe.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern3.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_cls_redirect.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_ipv6_route.skel.h
  GEN-SKEL [test_progs-no_alu32] load_bytes_relative.skel.h
  GEN-SKEL [test_progs-no_alu32] test_d_path.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sockhash_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_mmap.skel.h
  GEN-SKEL [test_progs-no_alu32] test_lwt_ip_encap.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall_bpf2bpf4.skel.h
  GEN-SKEL [test_progs-no_alu32] sockopt_inherit.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sock_fields.skel.h
  GEN-SKEL [test_progs-no_alu32] test_lirc_mode2_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_cubic.skel.h
  GEN-SKEL [test_progs-no_alu32] test_seg6_loop.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_ptr_as_arr.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tunnel_kern.skel.h
libbpf: elf: skipping unrecognized data section(27) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] bpf_iter_tcp4.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_bitfields.skel.h
  GEN-SKEL [test_progs-no_alu32] loop3.skel.h
  GEN-SKEL [test_progs-no_alu32] test_autoload.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_bitfields_probed.skel.h
  GEN-SKEL [test_progs-no_alu32] test_attach_probe.skel.h
  GEN-SKEL [test_progs-no_alu32] test_trace_ext_tracing.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ringbuf_multi.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf50.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_map_in_map.skel.h
  GEN-SKEL [test_progs-no_alu32] fentry_test.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pkt_access.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_storage_trace_itself.skel.h
  GEN-SKEL [test_progs-no_alu32] test_obj_id.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func3.skel.h
  GEN-SKEL [test_progs-no_alu32] tcp_rtt.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcpnotify_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_percpu_hash_map.skel.h
  GEN-SKEL [test_progs-no_alu32] kfree_skb.skel.h
libbpf: elf: skipping unrecognized data section(11) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_ordering.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta_subprogs.skel.h
  GEN-SKEL [test_progs-no_alu32] xdping_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_primitives.skel.h
  GEN-SKEL [test_progs-no_alu32] cgroup_skb_sk_lookup_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] xdp_dummy.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta.skel.h
  GEN-SKEL [test_progs-no_alu32] metadata_unused.skel.h
  GEN-SKEL [test_progs-no_alu32] tailcall4.skel.h
  GEN-SKEL [test_progs-no_alu32] freplace_connect4.skel.h
  GEN-SKEL [test_progs-no_alu32] test_perf_branches.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_existence.skel.h
  GEN-SKEL [test_progs-no_alu32] test_pinning.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_link.skel.h
  GEN-SKEL [test_progs-no_alu32] test_spin_lock.skel.h
  GEN-SKEL [test_progs-no_alu32] pyperf100.skel.h
  GEN-SKEL [test_progs-no_alu32] connect4_prog.skel.h
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
libbpf: elf: skipping unrecognized data section(8) .rodata.cst16
  GEN-SKEL [test_progs-no_alu32] test_btf_skc_cls_ingress.skel.h
  GEN-SKEL [test_progs-no_alu32] connect6_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_arrays.skel.h
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_kernel.skel.h
  GEN-SKEL [test_progs-no_alu32] netcnt_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_bpf_map.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_padding.skel.h
  GEN-SKEL [test_progs-no_alu32] btf_dump_test_case_syntax.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skb_ctx.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tc_neigh.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sk_lookup.skel.h
libbpf: elf: skipping unrecognized data section(45) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern4.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_flow.skel.h
  GEN-SKEL [test_progs-no_alu32] test_select_reuseport_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_get_stack_rawtp_err.skel.h
  GEN-SKEL [test_progs-no_alu32] test_verif_scale1.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_test_kern1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_misc_tcp_hdr_options.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ksyms.skel.h
  GEN-SKEL [test_progs-no_alu32] test_verif_scale2.skel.h
  GEN-SKEL [test_progs-no_alu32] modify_return.skel.h
  GEN-SKEL [test_progs-no_alu32] test_sysctl_loop2.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func1.skel.h
  GEN-SKEL [test_progs-no_alu32] perf_event_stackmap.skel.h
  GEN-SKEL [test_progs-no_alu32] test_map_lock.skel.h
  GEN-SKEL [test_progs-no_alu32] test_perf_buffer.skel.h
  GEN-SKEL [test_progs-no_alu32] fexit_bpf2bpf.skel.h
  GEN-SKEL [test_progs-no_alu32] test_global_func6.skel.h
  GEN-SKEL [test_progs-no_alu32] sendmsg6_prog.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task_btf.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_iter_task_stack.skel.h
  GEN-SKEL [test_progs-no_alu32] test_xdp_noinline.skel.h
  GEN-SKEL [test_progs-no_alu32] skb_pkt_end.skel.h
  GEN-SKEL [test_progs-no_alu32] profiler1.skel.h
libbpf: elf: skipping unrecognized data section(22) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] test_sockmap_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] loop4.skel.h
  GEN-SKEL [test_progs-no_alu32] strobemeta_nounroll1.skel.h
  GEN-SKEL [test_progs-no_alu32] test_skb_cgroup_id_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_tcp_check_syncookie_kern.skel.h
  GEN-SKEL [test_progs-no_alu32] test_ns_current_pid_tgid.skel.h
  GEN-SKEL [test_progs-no_alu32] test_btf_haskv.skel.h
libbpf: elf: skipping unrecognized data section(8) .maps.btf_map
  GEN-SKEL [test_progs-no_alu32] test_trampoline_count.skel.h
  GEN-SKEL [test_progs-no_alu32] map_ptr_kern.skel.h
  TEST-OBJ [test_progs-no_alu32] sockmap_listen.test.o
  TEST-OBJ [test_progs-no_alu32] snprintf_btf.test.o
  TEST-OBJ [test_progs-no_alu32] btf_split.test.o
  TEST-OBJ [test_progs-no_alu32] cls_redirect.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_noinline.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_adjust_tail.test.o
  TEST-OBJ [test_progs-no_alu32] reference_tracking.test.o
  TEST-OBJ [test_progs-no_alu32] enable_stats.test.o
  TEST-OBJ [test_progs-no_alu32] signal_pending.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_map.test.o
  TEST-OBJ [test_progs-no_alu32] trampoline_count.test.o
  TEST-OBJ [test_progs-no_alu32] btf_map_in_map.test.o
  TEST-OBJ [test_progs-no_alu32] send_signal.test.o
  TEST-OBJ [test_progs-no_alu32] ksyms_btf.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_attach_override.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_verif_scale.test.o
  TEST-OBJ [test_progs-no_alu32] tcpbpf_user.test.o
  TEST-OBJ [test_progs-no_alu32] flow_dissector_reattach.test.o
  TEST-OBJ [test_progs-no_alu32] fexit_bpf2bpf.test.o
  TEST-OBJ [test_progs-no_alu32] modify_return.test.o
  TEST-OBJ [test_progs-no_alu32] skeleton.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_bpf2bpf.test.o
  TEST-OBJ [test_progs-no_alu32] pe_preserve_elems.test.o
  TEST-OBJ [test_progs-no_alu32] align.test.o
  TEST-OBJ [test_progs-no_alu32] pkt_md_access.test.o
  TEST-OBJ [test_progs-no_alu32] trace_ext.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_cpumap_attach.test.o
  TEST-OBJ [test_progs-no_alu32] resolve_btfids.test.o
  TEST-OBJ [test_progs-no_alu32] vmlinux.test.o
  TEST-OBJ [test_progs-no_alu32] core_extern.test.o
  TEST-OBJ [test_progs-no_alu32] pkt_access.test.o
  TEST-OBJ [test_progs-no_alu32] tailcalls.test.o
  TEST-OBJ [test_progs-no_alu32] hashmap.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_map_raw_tp.test.o
  TEST-OBJ [test_progs-no_alu32] map_ptr.test.o
  TEST-OBJ [test_progs-no_alu32] flow_dissector_load_bytes.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_info.test.o
  TEST-OBJ [test_progs-no_alu32] tp_attach_query.test.o
  TEST-OBJ [test_progs-no_alu32] core_autosize.test.o
  TEST-OBJ [test_progs-no_alu32] perf_branches.test.o
  TEST-OBJ [test_progs-no_alu32] autoload.test.o
  TEST-OBJ [test_progs-no_alu32] section_names.test.o
  TEST-OBJ [test_progs-no_alu32] test_bpffs.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_perf.test.o
  TEST-OBJ [test_progs-no_alu32] queue_stack_map.test.o
  TEST-OBJ [test_progs-no_alu32] d_path.test.o
  TEST-OBJ [test_progs-no_alu32] probe_user.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_attach_autodetach.test.o
  TEST-OBJ [test_progs-no_alu32] raw_tp_test_run.test.o
  TEST-OBJ [test_progs-no_alu32] test_skb_pkt_end.test.o
  TEST-OBJ [test_progs-no_alu32] fexit_stress.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt_multi.test.o
  TEST-OBJ [test_progs-no_alu32] load_bytes_relative.test.o
  TEST-OBJ [test_progs-no_alu32] cpu_mask.test.o
  TEST-OBJ [test_progs-no_alu32] udp_limit.test.o
  TEST-OBJ [test_progs-no_alu32] sockmap_basic.test.o
  TEST-OBJ [test_progs-no_alu32] test_local_storage.test.o
  TEST-OBJ [test_progs-no_alu32] skb_helpers.test.o
  TEST-OBJ [test_progs-no_alu32] mmap.test.o
  TEST-OBJ [test_progs-no_alu32] obj_name.test.o
  TEST-OBJ [test_progs-no_alu32] sock_fields.test.o
  TEST-OBJ [test_progs-no_alu32] core_reloc.test.o
  TEST-OBJ [test_progs-no_alu32] l4lb_all.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_build_id_nmi.test.o
  TEST-OBJ [test_progs-no_alu32] attach_probe.test.o
  TEST-OBJ [test_progs-no_alu32] probe_read_user_str.test.o
  TEST-OBJ [test_progs-no_alu32] perf_event_stackmap.test.o
  TEST-OBJ [test_progs-no_alu32] raw_tp_writable_test_run.test.o
  TEST-OBJ [test_progs-no_alu32] btf_skc_cls_ingress.test.o
  TEST-OBJ [test_progs-no_alu32] btf.test.o
  TEST-OBJ [test_progs-no_alu32] metadata.test.o
  TEST-OBJ [test_progs-no_alu32] ringbuf.test.o
  TEST-OBJ [test_progs-no_alu32] perf_buffer.test.o
  TEST-OBJ [test_progs-no_alu32] fentry_fexit.test.o
  TEST-OBJ [test_progs-no_alu32] ksyms.test.o
  TEST-OBJ [test_progs-no_alu32] fexit_test.test.o
  TEST-OBJ [test_progs-no_alu32] link_pinning.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_tcp_ca.test.o
  TEST-OBJ [test_progs-no_alu32] ringbuf_multi.test.o
  TEST-OBJ [test_progs-no_alu32] btf_write.test.o
  TEST-OBJ [test_progs-no_alu32] trace_printk.test.o
  TEST-OBJ [test_progs-no_alu32] prog_run_xattr.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt_inherit.test.o
  TEST-OBJ [test_progs-no_alu32] test_lsm.test.o
  TEST-OBJ [test_progs-no_alu32] cg_storage_multi.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_iter.test.o
  TEST-OBJ [test_progs-no_alu32] task_fd_query_tp.test.o
  TEST-OBJ [test_progs-no_alu32] get_stack_raw_tp.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt_sk.test.o
  TEST-OBJ [test_progs-no_alu32] pinning.test.o
  TEST-OBJ [test_progs-no_alu32] btf_endian.test.o
  TEST-OBJ [test_progs-no_alu32] btf_dump.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_attach.test.o
  TEST-OBJ [test_progs-no_alu32] stacktrace_build_id.test.o
  TEST-OBJ [test_progs-no_alu32] ns_current_pid_tgid.test.o
  TEST-OBJ [test_progs-no_alu32] tcp_hdr_options.test.o
  TEST-OBJ [test_progs-no_alu32] varlen.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_link.test.o
  TEST-OBJ [test_progs-no_alu32] get_stackid_cannot_attach.test.o
  TEST-OBJ [test_progs-no_alu32] spinlock.test.o
  TEST-OBJ [test_progs-no_alu32] fentry_test.test.o
  TEST-OBJ [test_progs-no_alu32] task_fd_query_rawtp.test.o
  TEST-OBJ [test_progs-no_alu32] xdp.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_skb_sk_lookup.test.o
  TEST-OBJ [test_progs-no_alu32] test_global_funcs.test.o
  TEST-OBJ [test_progs-no_alu32] tcp_rtt.test.o
  TEST-OBJ [test_progs-no_alu32] sk_assign.test.o
  TEST-OBJ [test_progs-no_alu32] select_reuseport.test.o
  TEST-OBJ [test_progs-no_alu32] kfree_skb.test.o
  TEST-OBJ [test_progs-no_alu32] rdonly_maps.test.o
  TEST-OBJ [test_progs-no_alu32] sk_storage_tracing.test.o
  TEST-OBJ [test_progs-no_alu32] core_retro.test.o
  TEST-OBJ [test_progs-no_alu32] sk_lookup.test.o
  TEST-OBJ [test_progs-no_alu32] skb_ctx.test.o
  TEST-OBJ [test_progs-no_alu32] tcp_estats.test.o
  TEST-OBJ [test_progs-no_alu32] btf_dedup_split.test.o
  TEST-OBJ [test_progs-no_alu32] cgroup_attach_multi.test.o
  TEST-OBJ [test_progs-no_alu32] hash_large_key.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_devmap_attach.test.o
  TEST-OBJ [test_progs-no_alu32] test_profiler.test.o
  TEST-OBJ [test_progs-no_alu32] raw_tp_writable_reject_nbd_invalid.test.o
  TEST-OBJ [test_progs-no_alu32] test_overhead.test.o
  TEST-OBJ [test_progs-no_alu32] flow_dissector.test.o
  TEST-OBJ [test_progs-no_alu32] sockmap_ktls.test.o
  TEST-OBJ [test_progs-no_alu32] xdp_link.test.o
  TEST-OBJ [test_progs-no_alu32] global_data_init.test.o
  TEST-OBJ [test_progs-no_alu32] connect_force_port.test.o
  TEST-OBJ [test_progs-no_alu32] map_init.test.o
  TEST-OBJ [test_progs-no_alu32] sockopt.test.o
  TEST-OBJ [test_progs-no_alu32] global_data.test.o
  TEST-OBJ [test_progs-no_alu32] send_signal_sched_switch.test.o
  TEST-OBJ [test_progs-no_alu32] map_lock.test.o
  TEST-OBJ [test_progs-no_alu32] endian.test.o
  TEST-OBJ [test_progs-no_alu32] subprogs.test.o
  TEST-OBJ [test_progs-no_alu32] bpf_obj_id.test.o
  EXT-OBJ  [test_progs-no_alu32] test_progs.o
  EXT-OBJ  [test_progs-no_alu32] cgroup_helpers.o
  EXT-OBJ  [test_progs-no_alu32] trace_helpers.o
  EXT-OBJ  [test_progs-no_alu32] network_helpers.o
  EXT-OBJ  [test_progs-no_alu32] testing_helpers.o
  EXT-OBJ  [test_progs-no_alu32] btf_helpers.o
  EXT-COPY [test_progs-no_alu32] urandom_read btf_dump_test_case_bitfields.c btf_dump_test_case_ordering.c btf_dump_test_case_padding.c btf_dump_test_case_syntax.c btf_dump_test_case_packing.c btf_dump_test_case_namespacing.c btf_dump_test_case_multidim.c
  BINARY   test_progs-no_alu32
  BINARY   test_current_pid_tgid_new_ns
  BINARY   test_sock_addr
  BINARY   test_skb_cgroup_id_user
  BINARY   flow_dissector_load
  BINARY   test_flow_dissector
  BINARY   test_tcp_check_syncookie_user
  BINARY   test_lirc_mode2_user
  BINARY   xdping
  CXX      test_cpp
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/libbpf/
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/map_perf_ring.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/xlated_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/iter.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/tracelog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/link.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/perf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/btf.o
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/libbpf/libbpf.a
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//bootstrap/bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/vmlinux.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/bpf_helper_defs.h
  MKDIR    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/bpf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/nlattr.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/btf.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf_errno.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/str_error.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/netlink.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/bpf_prog_linfo.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf_probes.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/xsk.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/hashmap.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/btf_dump.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/ringbuf.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/staticobjs/libbpf-in.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool//libbpf/libbpf.a
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/profiler.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/profiler.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/prog.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/btf_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/net.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/struct_ops.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/netlink_dumper.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/common.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/cgroup.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/gen.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/main.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/json_writer.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/cfg.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/map.o
  CLANG    /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/pid_iter.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/pid_iter.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/pids.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/feature.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/jit_disasm.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/disasm.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools/bpftool/bpftool
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//vmlinux.h
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower.bpf.o
  GEN      /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower.skel.h
  CC       /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower.o
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf/tools//runqslower
  CC       bench.o
  CC       bench_count.o
  CC       bench_rename.o
  CC       bench_trigger.o
  CC       bench_ringbufs.o
  BINARY   bench
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/bpf'
LKP SKIP net.l2tp.sh
2021-01-07 17:11:49 make -C ../../../tools/testing/selftests/net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net'
make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_bpf_numa.c -lnuma -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/tls
tls.c:106:2: error: unknown type name ‘u16’
  u16 tls_version;
  ^~~
tls.c:107:2: error: unknown type name ‘u16’
  u16 cipher_type;
  ^~~
tls.c: In function ‘tls_setup’:
tls.c:136:27: error: storage size of ‘tls12’ isn’t known
  union tls_crypto_context tls12;
                           ^~~~~
tls.c:150:21: error: ‘tls12_crypto_info_chacha20_poly1305’ undeclared (first use in this function)
   tls12_sz = sizeof(tls12_crypto_info_chacha20_poly1305);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tls.c:150:21: note: each undeclared identifier is reported only once for each function it appears in
tls.c:153:21: error: ‘tls12_crypto_info_aes_gcm_128’ undeclared (first use in this function)
   tls12_sz = sizeof(tls12_crypto_info_aes_gcm_128);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tls.c:136:27: warning: unused variable ‘tls12’ [-Wunused-variable]
  union tls_crypto_context tls12;
                           ^~~~~
make: *** [../lib.mk:139: /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net/tls] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-4f336e88a870ecc56832154dff22853a3ca33e24/tools/testing/selftests/net'

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! /cephfs/jenkins/jobs/lkp-mptcp/workspace/lkp-customers/linux/mptcp/kselftest/lkp-skl-d01/kernel-selftests-bm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-7.6-kselftests
kernel-selftests:
  group: net
job_origin: "/cephfs/jenkins/jobs/lkp-mptcp/workspace/lkp-customers/linux/mptcp/kselftest/lkp-skl-d01/kernel-selftests-bm.yaml"
queue: bisect
testbox: lkp-skl-d01
commit: 4f336e88a870ecc56832154dff22853a3ca33e24
branch: mptcp/export
name: "/cephfs/jenkins/jobs/lkp-mptcp/workspace/lkp-customers/linux/mptcp/kselftest/lkp-skl-d01/kernel-selftests-bm.yaml"
kernel_cmdline: 
tbox_group: lkp-skl-d01
submit_id: 5ff729496a9e7711782cd7ed
job_file: "/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4f336e88a870ecc56832154dff22853a3ca33e24-20210108-4472-1ljrb1y-0.yaml"
id: bc4382e246284d529255d2f8c0e285a8343b58d9
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d01
model: Skylake
nr_cpu: 8
memory: 28G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x50014ee20d26b072-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part1"
swap_partitions: "/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part3"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part2"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
cpu_info: skylake i7-6700
bios_version: 1.2.8

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/testbox/lkp-skl-d01
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kconfig:
- CONFIG_USER_NS=y
- CONFIG_BPF_SYSCALL=y
- CONFIG_TEST_BPF=m
- CONFIG_NUMA=y ~ ">= v5.6-rc1"
- CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
- CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
- CONFIG_IPV6=y
- CONFIG_IPV6_MULTIPLE_TABLES=y
- CONFIG_VETH=y
- CONFIG_NET_IPVTI=m
- CONFIG_IPV6_VTI=m
- CONFIG_DUMMY=y
- CONFIG_BRIDGE=y
- CONFIG_VLAN_8021Q=y
- CONFIG_IFB=y
- CONFIG_NETFILTER=y
- CONFIG_NETFILTER_ADVANCED=y
- CONFIG_NF_CONNTRACK=m
- CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
- CONFIG_IP6_NF_IPTABLES=m
- CONFIG_IP_NF_IPTABLES=m
- CONFIG_IP6_NF_NAT=m
- CONFIG_IP_NF_NAT=m
- CONFIG_NF_TABLES=m
- CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
- CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
- CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
- CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
- CONFIG_NET_SCH_FQ=m
- CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
- CONFIG_NET_SCH_NETEM=y
- CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
- CONFIG_KALLSYMS=y
rootfs: debian-10.4-x86_64-20200603.cgz
enqueue_time: 2021-01-07 23:31:21.960891984 +08:00
compiler: gcc-9
_id: 5ff729496a9e7711782cd7ed
_rt: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24"

#! schedule options
user: lkp
LKP_SERVER: internal-lkp-server
result_root: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/0"
scheduler_version: "/lkp/lkp/.src-20210107-094228"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-4f336e88a870ecc56832154dff22853a3ca33e24-20210108-4472-1ljrb1y-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6-kselftests
- branch=mptcp/export
- commit=4f336e88a870ecc56832154dff22853a3ca33e24
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/vmlinuz-5.10.0-rc4-01243-g4f336e88a870
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201231.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-cb0debfe-1_20201231.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210106-112510/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0

#! queue options
queue_cmdline_keys:
- branch
- commit

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/4f336e88a870ecc56832154dff22853a3ca33e24/vmlinuz-5.10.0-rc4-01243-g4f336e88a870"
dequeue_time: 2021-01-08 00:21:17.360621177 +08:00

#! /lkp/lkp/.src-20210107-094228/include/site/inn
job_state: finished
loadavg: 1.22 1.04 0.52 1/179 19060
start_time: '1610036321'
end_time: '1610036602'
version: "/lkp/lkp/.src-20210107-094301:666daf1f-dirty:5684adcbd"

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C bpf
make -C ../../../tools/testing/selftests/net

--5mCyUwZo2JvN/JJP--
