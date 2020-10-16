Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2E29044F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406906AbgJPLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 07:47:52 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com ([40.107.2.139]:6063
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406899AbgJPLrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1yn9Dg+6V++ridZ389YrFyav7LRuLG+UvKSuZnxgBGzAAPjvRShUQjZhFxFNWiDG/Ju4KIZksO5iuhAo7PvqaZZi1GK8pAZrlm3ZT4Mh1FFIIu1brv1wFhS533DHnQhl+Q09NUikI906VSQaBJ8c0IhLt44IelcqlgHBNKmGlcARBR/gqazKro12E2uklSdijHphpBeiCR/lLVkopIN/q3VxIfWxsHHZGzYcL/1V+HRkwThyqnPqfWopTFwNU/f4TbPnyVRtu6akmWMWQ5rj5bOBn94H9H66RUxVj8MRtrKaIfkffTreDiNI/ytf0LVkARwxpzC2CndULRec1oIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUPfbdtoui009VBXsaIQsKOXu8lcyuntGHF1g2jDqZE=;
 b=jirbB9NLe25JRHFmKnBHqaZ4oQupHWEAg/Dk/ojzPT8LPSKbKFzBqTZvCrABNaWK1G6rS6Z/VQNzVy1eEevO4qTlmO799v86yuYbZRMPDA3sYblkl6NSSAgNKQsaZvdpQF2jcStDONSVM1vs2XjhL33GyN20zaXkcHy32RO/U9sk/dGLpIBs9djscbB9yt9sCr5xodkutgpRxRjFAN9b3Z0WA1ngO89D9DhK0S3mXbSKa5gWh/k+3ohNUjLw6v5f328EIDghWReumVLUzNRV1utLAth8+12RduTZXs5NrXOv26clX4X9j5xsn0cn4kq7zb3qKMfoE2ZOgINOmM7zzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUPfbdtoui009VBXsaIQsKOXu8lcyuntGHF1g2jDqZE=;
 b=Xs8XyK/nJnl87p4wZLSNLsibYDaO5R1ClR/YgEAluimjmVPJ2JUWjFAI3sy+fd7fqTd5F2T/37fNM8dkc0zPbaaOg0CRuPC4gx2VimoA0QbHwJVtNYdDRazyjOa2Vmtgg+K3nGKDdYHRKEDp/YTFdMAHJnkK8hIMHNDIDTd5w6Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0702MB3772.eurprd07.prod.outlook.com (2603:10a6:7:8e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Fri, 16 Oct 2020 11:47:45 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3477.019; Fri, 16 Oct 2020
 11:47:45 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH] perf tools: Fix crash with non-jited bpf progs
Date:   Fri, 16 Oct 2020 14:47:18 +0300
Message-Id: <20201016114718.54332-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [131.228.2.26]
X-ClientProxiedBy: HE1PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::46) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.26) by HE1PR0102CA0033.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 11:47:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e864c59e-9f7b-44b9-042a-08d871c94bf7
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB377227C142331D029642334FB4030@HE1PR0702MB3772.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l0ltcTELlyMNemjkOsurjPmW1i3vub2AcdpTOs18/IHTtxyLEWY8d2O3uvhw4hHR5fPDWdt6PSu34ykK+NmiPfY04Mp/ZQCtib/LalXzq5mh238qYv4id2fGapR4DRxmJArVezF/YrJrx0jHDHSprRah0q8q2Uyygds3+Xuj7ByYiEA1VROmlOfp6s7MCL2ZVZo5loFURiOy4AlOOSX9SW7UbR3VwkiPwPabVI1MzHbHwUvR6j6EH5nqPBnTiaE8jrpHVYQISOwqo7K1NUmAU/ijMrsPuPbfiOYM/fj5a9+CyDPx3cV+H6gH8jZM0MBvSdG0iL6Ussq4NjOCSEFnPoNumg94Jqc/qOi/xfnyYpwdRWQGtfS7ULzJHFkomtD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(5660300002)(2906002)(83380400001)(52116002)(6666004)(956004)(6512007)(2616005)(186003)(86362001)(4326008)(6506007)(316002)(16526019)(26005)(107886003)(66946007)(66476007)(66556008)(110136005)(36756003)(8936002)(34490700002)(1076003)(8676002)(103116003)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Rzwcny8ryIkdGmhOiWR6r+NMUzb7S9PI2F4nKN5/5Ni2+zYaS4qUlkJQM2t4qEY0nosnjCN2wwrKEvT4glW3pXjelCdeLO48e7uKYaLuOwp1mIYfJ1GEwvMMv8lDQZYhdTRHR6W08QF7ZW8FZ8RRW8HvnTMNjgPgXak/kaSux2Fvfcx8ly8porimRG+VyjK5SXHeHBTIrlUVSnukdaYNBk5MAIhXhP7JZ6veF94kiomZ1YYJ0gTWV8HQftPdplneXOWdUVqDks0Eun57nygGduuvJkOE9srwiXP4Yr0v9d6GJ6GTejn70/SMVBySaWdYq8cKZU75oXQyh1b8NAwCw5mv0GST8hl1EMVJ1EG8KHTnkP3yDGoliash1Y1PfvJvEm2b+f1KmkMPjI1/cZXRyhfTJQE9/pQ+lzsszxKWXmYpZNsDEInGHylbDd1HqvZZfRTpFRZSjw4MIc/rci3ouEgRGhZEI8p31TqjvwteuJJA804O4a0f09gknZLzl5nvaqZI04DBtz85rtuyxx9RzyYKUEmOHPTdVMLUQzTI6In5f/1rHlI/pjD8iHfq0AvvL2wffBuODcRdD0I44pljfiV6nt59/d0cYQwst5dv87jJq8Whg7lKvNXZS7dER1+63+VsQ4nHeog5Xrx3f4G8CQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e864c59e-9f7b-44b9-042a-08d871c94bf7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 11:47:45.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LX2QxMObCgaLMHLrvy8uQSFz5x7NVyXII+bSwH5m7ncqpEFuTxaNLu+xc9hCugcKEyoEr2gPClCAU7yf2warb3weGJZKfW7vrWgsCKEmevc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3772
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addr in PERF_RECORD_KSYMBOL events for non-jited bpf progs points to
the bpf interpreter, ie. within kernel text section. When processing the
unregister event, this causes unexpected removal of vmlinux_map,
crashing perf later in cleanup:

  # perf record -- timeout --signal=INT 2s /usr/share/bcc/tools/execsnoop
  PCOMM            PID    PPID   RET ARGS
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.208 MB perf.data (5155 samples) ]
  perf: tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
  Aborted (core dumped)

  # perf script -D|grep KSYM
  0 0xa40 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b530 len 0 type 1 flags 0x0 name bpf_prog_f958f6eb72ef5af6
  0 0xab0 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b530 len 0 type 1 flags 0x0 name bpf_prog_8c42dee26e8cd4c2
  0 0xb20 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b530 len 0 type 1 flags 0x0 name bpf_prog_f958f6eb72ef5af6
  108563691893 0x33d98 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3b0 len 0 type 1 flags 0x0 name bpf_prog_bc5697a410556fc2_syscall__execve
  108568518458 0x34098 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3f0 len 0 type 1 flags 0x0 name bpf_prog_45e2203c2928704d_do_ret_sys_execve
  109301967895 0x34830 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3b0 len 0 type 1 flags 0x1 name bpf_prog_bc5697a410556fc2_syscall__execve
  109302007356 0x348b0 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3f0 len 0 type 1 flags 0x1 name bpf_prog_45e2203c2928704d_do_ret_sys_execve
  perf: tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.

Here the addresses match the bpf interpreter:

  # grep -e ffffffffa9b6b530 -e ffffffffa9b6b3b0 -e ffffffffa9b6b3f0 /proc/kallsyms
  ffffffffa9b6b3b0 t __bpf_prog_run224
  ffffffffa9b6b3f0 t __bpf_prog_run192
  ffffffffa9b6b530 t __bpf_prog_run32

Fix by not allowing vmlinux_map to be removed by PERF_RECORD_KSYMBOL
unregister event.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/util/machine.c | 11 ++++++++++-
 tools/perf/util/symbol.c  |  7 +++++++
 tools/perf/util/symbol.h  |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 85587de027a5..d93d35463c61 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -786,11 +786,20 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 					       union perf_event *event,
 					       struct perf_sample *sample __maybe_unused)
 {
+	struct symbol *sym;
 	struct map *map;
 
 	map = maps__find(&machine->kmaps, event->ksymbol.addr);
-	if (map)
+	if (!map)
+		return 0;
+
+	if (map != machine->vmlinux_map)
 		maps__remove(&machine->kmaps, map);
+	else {
+		sym = dso__find_symbol(map->dso, map->map_ip(map, map->start));
+		if (sym)
+			dso__delete_symbol(map->dso, sym);
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5151a8c0b791..6bf8e74ea1d1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -515,6 +515,13 @@ void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 	}
 }
 
+void dso__delete_symbol(struct dso *dso, struct symbol *sym)
+{
+	rb_erase_cached(&sym->rb_node, &dso->symbols);
+	symbol__delete(sym);
+	dso__reset_find_symbol_cache(dso);
+}
+
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 {
 	if (dso->last_find_result.addr != addr || dso->last_find_result.symbol == NULL) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 03e264a27cd3..60345691db09 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -130,6 +130,8 @@ int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
 
 void dso__insert_symbol(struct dso *dso,
 			struct symbol *sym);
+void dso__delete_symbol(struct dso *dso,
+			struct symbol *sym);
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name);
-- 
2.26.2

