Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82B628AF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgJLHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgJLHyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:54:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C7Vvwv020445;
        Mon, 12 Oct 2020 03:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=mLBlRaYtPcOz8S27LAl/DMp9ftbbUdwCvO3JKWiA9gs=;
 b=JADXVl4shgKJaIuQOdGtxKBu79RnJxBHnRrBg9WwUlnj5NjKlI8n95wlmuvUEP1RF4cw
 h01PUPqqhRc8jzBJw+hUBwjuDqi1mNG83ZsOXhpAEY3SfdQBewUMSw26T2dM0aiuiwhI
 Fzl9hHAG9up7qtxnXHpA8dYKWnM5rJcpkj/fGcZtjOLoqqoZK4v8SvtmnXwEp+BhMD7y
 Bws1D+/6owM1i19cTHg66h8fBHv7Y+cWWwQFIx09YkOOg/DyyGvkV+W8Hbdk/LHzBVu9
 tfgAB8Y98g5wG6xEhS6L8T8qDcDBsA7A/P+aD4Ucju9AeTEeTu19eJeCnM+/d4goUY9n Mw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 344ju0gk9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 03:54:44 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09C7rMch031154;
        Mon, 12 Oct 2020 07:54:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 34347h0wny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 07:54:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09C7se1Z25362840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 07:54:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E13EA405F;
        Mon, 12 Oct 2020 07:54:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7753A405B;
        Mon, 12 Oct 2020 07:54:39 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Oct 2020 07:54:39 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: autofs crash with latest linux-next
Date:   Mon, 12 Oct 2020 09:54:39 +0200
Message-ID: <yt9d1ri3nakg.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_03:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1031 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on s390 i see the following crash with linux-next:

[ 4525.432605] Unable to handle kernel pointer dereference in virtual kernel address space
[ 4525.432612] Failing address: 0000000000000000 TEID: 0000000000000483
[ 4525.432613] Fault in home space mode while using kernel ASCE.
[ 4525.432616] AS:00000000cf048007 R3:00000001fffec007 S:00000001ffff1800 P:000000000000003d 
[ 4525.432640] Oops: 0004 ilc:3 [#1] SMP 
[ 4525.432644] Modules linked in: dm_crypt encrypted_keys lcs ctcm fsm nfsv3 nfs_acl nfs lockd grace quota_v2 quota_tree tun overlay ntfs exfat vfat fat sctp vfio_pci irqbypass vfio_virqfd scsi_debug vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb vfio_ap kvm loop nft_counter bridge stp llc dm_service_time nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua s390_trng vfio_ccw vfio_mdev mdev vfio_iommu_type1 vfio zcrypt_cex4 eadm_sch sch_fq_codel ip_tables x_tables ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4 [last unloaded: dummy_del_mod]
[ 4525.432691] CPU: 9 PID: 1050921 Comm: find Tainted: G           OE     5.9.0-20201011.rc8.git0.d67bc7812221.300.fc32.s390x+next #1
[ 4525.432693] Hardware name: IBM 3906 M04 704 (LPAR)
[ 4525.432694] Krnl PSW : 0704d00180000000 00000000cde29f70 (__kernel_write+0x1a0/0x2a0)
[ 4525.432702]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[ 4525.432704] Krnl GPRS: 0000000100067343 0000000000000000 0000000000000130 0000000000000001
[ 4525.432705]            0000000000000006 000000005f82be2f 0000000000000130 000000008c6ab568
[ 4525.432728]            0000000084441f00 0000000000000000 0000000000000130 0000000084441f00
[ 4525.432729]            0000000081476000 0000000000000001 00000000cde29ef4 000003e002f5b6f0
[ 4525.432735] Krnl Code: 00000000cde29f62: a7280000		lhi	%r2,0
                          00000000cde29f66: a7f4ff9d		brc	15,00000000cde29ea0
                         #00000000cde29f6a: e310f0f00004	lg	%r1,240(%r15)
                         >00000000cde29f70: e31090000024	stg	%r1,0(%r9)
                          00000000cde29f76: 9104b044		tm	68(%r11),4
                          00000000cde29f7a: a784000f		brc	8,00000000cde29f98
                          00000000cde29f7e: e31003400004	lg	%r1,832
                          00000000cde29f84: b904002a		lgr	%r2,%r10
[ 4525.432748] Call Trace:
[ 4525.432750]  [<00000000cde29f70>] __kernel_write+0x1a0/0x2a0 
[ 4525.432752] ([<00000000cde29ef4>] __kernel_write+0x124/0x2a0)
[ 4525.432756]  [<000003ff80004cfa>] autofs_write+0x5a/0x140 [autofs4] 
[ 4525.432758]  [<000003ff80005262>] autofs_notify_daemon.constprop.0+0x10a/0x1c8 [autofs4] 
[ 4525.432760]  [<000003ff80005872>] autofs_wait+0x552/0x718 [autofs4] 
[ 4525.432762]  [<000003ff800033ca>] autofs_mount_wait+0x5a/0xb0 [autofs4] 
[ 4525.432764]  [<000003ff800048b2>] autofs_d_automount+0x102/0x278 [autofs4] 
[ 4525.432766]  [<00000000cde398fe>] __traverse_mounts+0x9e/0x270 
[ 4525.432768]  [<00000000cde3e7ee>] step_into+0x1de/0x280 
[ 4525.432770]  [<00000000cde3f000>] open_last_lookups+0xb8/0x3f8 
[ 4525.432772]  [<00000000cde3f726>] path_openat+0x86/0x1d0 
[ 4525.432773]  [<00000000cde425b0>] do_filp_open+0x78/0x118 
[ 4525.432776]  [<00000000cde278d0>] do_sys_openat2+0xa8/0x168 
[ 4525.432778]  [<00000000cde27cfa>] __s390x_sys_openat+0x6a/0x98 
[ 4525.432781]  [<00000000ce64f2e8>] system_call+0xdc/0x2a4 
[ 4525.432782] Last Breaking-Event-Address:
[ 4525.432783]  [<00000000cde29efc>] __kernel_write+0x12c/0x2a0

This seems to be caused by the result of merging 0fb702791bf ("autofs:
use __kernel_write() for the autofs pipe writing") and 4d03e3cc5982
("fs: don't allow kernel reads and writes without iter
ops"). __kernel_write() gets now called with a NULL pointer as pos
argument, but __kernel_write expects a valid pointer as it
fetches/stores the pos value there. Is there a fix pending somewhere?

Thanks
Sven
