Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557B229F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbgGVSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 14:44:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15688 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgGVSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:44:56 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MIZKTe000862
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:44:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=091r98mpbHHVZrheekCNJu9nc9xPl3jkMv48nBFufDg=;
 b=PmbHpiOPUv+2z+Kcgt2LK7K+Fb9nrIJXnOvVucsHtnVg+JUXXpwWCtNisrmjb4FxJhQJ
 nlcOqJZc5l0oGIfw1ehJaRRAQR2zXt3cRRQ05J43GS+69lTxu9yodKc4ga0NK11SD06r
 je5laM+BH1Aa4h+UM2Rbu1d8RSuI5W2m9RI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32esyurd4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:44:55 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 11:44:54 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5B50262E4CDB; Wed, 22 Jul 2020 11:42:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 0/4] bpf: fix stackmap on perf_events with PEBS
Date:   Wed, 22 Jul 2020 11:42:06 -0700
Message-ID: <20200722184210.4078256-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_10:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling get_perf_callchain() on perf_events from PEBS entries may cause
unwinder errors. To fix this issue, perf subsystem fetches callchain earl=
y,
and marks perf_events are marked with __PERF_SAMPLE_CALLCHAIN_EARLY.
Similar issue exists when BPF program calls get_perf_callchain() via
helper functions. For more information about this issue, please refer to
discussions in [1].

This set fixes this issue with helper proto bpf_get_stackid_pe and
bpf_get_stack_pe.

[1] https://lore.kernel.org/lkml/ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.=
com/

Changes v3 =3D> v4:
1. Fix error check logic in bpf_get_stackid_pe and bpf_get_stack_pe.
   (Alexei)
2. Do not allow attaching BPF programs with bpf_get_stack|stackid to
   perf_event with precise_ip > 0, but not proper callchain. (Alexei)
3. Add selftest get_stackid_cannot_attach.

Changes v2 =3D> v3:
1. Fix handling of stackmap skip field. (Andrii)
2. Simplify the code in a few places. (Andrii)

Changes v1 =3D> v2:
1. Simplify the design and avoid introducing new helper function. (Andrii=
)

Song Liu (4):
  bpf: separate bpf_get_[stack|stackid] for perf events BPF
  bpf: fail PERF_EVENT_IOC_SET_BPF when bpf_get_[stack|stackid] cannot
    work
  selftests/bpf: add callchain_stackid
  selftests/bpf: add get_stackid_cannot_attach

 include/linux/bpf.h                           |   2 +
 include/linux/filter.h                        |   3 +-
 kernel/bpf/stackmap.c                         | 184 ++++++++++++++++--
 kernel/bpf/verifier.c                         |   3 +
 kernel/events/core.c                          |  18 ++
 kernel/trace/bpf_trace.c                      |   4 +-
 .../prog_tests/get_stackid_cannot_attach.c    |  91 +++++++++
 .../bpf/prog_tests/perf_event_stackmap.c      | 116 +++++++++++
 .../selftests/bpf/progs/perf_event_stackmap.c |  59 ++++++
 9 files changed, 459 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stackid_ca=
nnot_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_event_sta=
ckmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/perf_event_stackmap=
.c

--
2.24.1
