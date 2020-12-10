Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B962D67CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404335AbgLJT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:59:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2247 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390146AbgLJT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:58:49 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsPl35jC3z67M6B;
        Fri, 11 Dec 2020 03:54:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 10 Dec 2020 20:58:02 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 19:58:01 +0000
Subject: Re: [BUG] jevents problem when cross building Re: [PATCH 2/3] perf
 tools: Allow to enable/disable events via control file
From:   John Garry <john.garry@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Budankov <abudankov@huawei.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava> <20201210171503.GA195565@kernel.org>
 <20201210171903.GB195565@kernel.org> <20201210172608.GC195565@kernel.org>
 <30e7907d-868a-a673-59a7-3bb4766093b4@huawei.com>
 <20201210181708.GD195565@kernel.org>
 <1a608e92-d0d0-2e5e-ba7e-e9fa2e02b0f9@huawei.com>
Message-ID: <650baaf2-36b6-a9e2-ff49-963ef864c1f3@huawei.com>
Date:   Thu, 10 Dec 2020 19:57:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1a608e92-d0d0-2e5e-ba7e-e9fa2e02b0f9@huawei.com>
Content-Type: multipart/mixed;
        boundary="------------F62C2E5729283149E21160D0"
Content-Language: en-US
X-Originating-IP: [10.210.172.228]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------F62C2E5729283149E21160D0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2020 18:27, John Garry wrote:
>> Its unpublished, I'll send it to the tmp.perf/core branch now.
> 
> I use cross-compile for arm64 to build, and it's ok.
> 
> I notice that the failures are for architectures which don't have an 
> entry under pmu-events/arch, so maybe we're missing some 'weak' 
> definition of pmu_sys_event_tables.
> 
> I'll check now.
> 

Hi Arnaldo,

Can you try this on top:

----8<-----

 From 201aa2cb7bc8723765afd84a5d3972248af0f0a1 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Thu, 10 Dec 2020 19:45:14 +0000
Subject: [PATCH] perf jevents: Add system events table for empty mapping

For architectures which have no PMU event lists - like arm32 - an empty
mapping table is printed. This is how the "pmu_events_map" symbol -
referenced in util/pmu.c::perf_pmu__find_map() - is created for those
architectures.

Since pmu-events.c now includes a new table - "pmu_sys_event_tables" -
which is also referenced from util/pmu.c, also add this for the empty
mappings.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/pmu-events/jevents.c 
b/tools/perf/pmu-events/jevents.c
index e930096ad713..28e20d9ec0f5 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -816,19 +816,30 @@ static void print_mapping_test_table(FILE *outfp)
  	fprintf(outfp, "},\n");
  }

+static void print_system_event_mapping_table_prefix(FILE *outfp)
+{
+	fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
+}
+
+static void print_system_event_mapping_table_suffix(FILE *outfp)
+{
+	fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
+
+	fprintf(outfp, "\n};\n");
+}
+
  static int process_system_event_tables(FILE *outfp)
  {
  	struct sys_event_table *sys_event_table;

-	fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
+	print_system_event_mapping_table_prefix(outfp);

  	list_for_each_entry(sys_event_table, &sys_event_tables, list) {
  		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
  			sys_event_table->soc_id);
  	}
-	fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");

-	fprintf(outfp, "\n};\n");
+	print_system_event_mapping_table_suffix(outfp);

  	return 0;
  }
@@ -938,6 +949,9 @@ static void create_empty_mapping(const char 
*output_file)
  	fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
  	print_mapping_table_prefix(outfp);
  	print_mapping_table_suffix(outfp);
+	print_system_event_mapping_table_prefix(outfp);
+	print_system_event_mapping_table_suffix(outfp);
+
  	fclose(outfp);
  }

---->8----

Obviously I never tested building for one of test architectures which 
does not use PMU events - sorry!

I'll review this more tomorrow.

Thanks!


> 
>>
>> More results from testing:
>>
>>    59    13.57 ubuntu:16.04-x-arm            : FAIL 
>> arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 
>> 20160609
>>
>> [perfbuilder@five ~]$ tail -20 dm.log/ubuntu\:16.04-x-arm
>>    CC       /tmp/build/perf/util/expr.o
>>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>>    LD       /tmp/build/perf/util/perf-in.o
>>    LD       /tmp/build/perf/perf-in.o
>>    LINK     /tmp/build/perf/perf
>> /tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
>> /git/linux/tools/perf/util/pmu.c:816: undefined reference to 
>> `pmu_sys_event_tables'
>> /git/linux/tools/perf/util/pmu.c:816: undefined reference to 
>> `pmu_sys_event_tables'
>> /tmp/build/perf/perf-in.o: In function `pmu_add_sys_aliases':
>> /git/linux/tools/perf/util/pmu.c:886: undefined reference to 
>> `pmu_sys_event_tables'
>> /git/linux/tools/perf/util/pmu.c:886: undefined reference to 
>> `pmu_sys_event_tables'
>> collect2: error: ld returned 1 exit status
>> Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
>> make[2]: *** [/tmp/build/perf/perf] Error 1
>> Makefile.perf:232: recipe for target 'sub-make' failed
>> make[1]: *** [sub-make] Error 2
>> Makefile:69: recipe for target 'all' failed
>> make: *** [all] Error 2
>> make: Leaving directory '/git/linux/tools/perf'
>> + exit 1 


--------------F62C2E5729283149E21160D0
Content-Type: text/plain; charset="UTF-8";
	name="0001-perf-jevents-Add-system-events-table-for-empty-mappi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-perf-jevents-Add-system-events-table-for-empty-mappi.pa";
	filename*1="tch"

RnJvbSAyMDFhYTJjYjdiYzg3MjM3NjVhZmQ4NGE1ZDM5NzIyNDhhZjBmMGExIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5j
b20+CkRhdGU6IFRodSwgMTAgRGVjIDIwMjAgMTk6NDU6MTQgKzAwMDAKU3ViamVjdDogW1BB
VENIXSBwZXJmIGpldmVudHM6IEFkZCBzeXN0ZW0gZXZlbnRzIHRhYmxlIGZvciBlbXB0eSBt
YXBwaW5nCgpGb3IgYXJjaGl0ZWN0dXJlcyB3aGljaCBoYXZlIG5vIFBNVSBldmVudCBsaXN0
cyAtIGxpa2UgYXJtMzIgLSBhbiBlbXB0eQptYXBwaW5nIHRhYmxlIGlzIHByaW50ZWQuIFRo
aXMgaXMgaG93IHRoZSAicG11X2V2ZW50c19tYXAiIHN5bWJvbCAtCnJlZmVyZW5jZWQgaW4g
dXRpbC9wbXUuYzo6cGVyZl9wbXVfX2ZpbmRfbWFwKCkgLSBpcyBjcmVhdGVkIGZvciB0aG9z
ZQphcmNoaXRlY3R1cmVzLgoKU2luY2UgcG11LWV2ZW50cy5jIG5vdyBpbmNsdWRlcyBhIG5l
dyB0YWJsZSAtICJwbXVfc3lzX2V2ZW50X3RhYmxlcyIgLQp3aGljaCBpcyBhbHNvIHJlZmVy
ZW5jZWQgZnJvbSB1dGlsL3BtdS5jLCBhbHNvIGFkZCB0aGlzIGZvciB0aGUgZW1wdHkKbWFw
cGluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5j
b20+CgpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2pldmVudHMuYyBiL3Rv
b2xzL3BlcmYvcG11LWV2ZW50cy9qZXZlbnRzLmMKaW5kZXggZTkzMDA5NmFkNzEzLi4yOGUy
MGQ5ZWMwZjUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9qZXZlbnRzLmMK
KysrIGIvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2pldmVudHMuYwpAQCAtODE2LDE5ICs4MTYs
MzAgQEAgc3RhdGljIHZvaWQgcHJpbnRfbWFwcGluZ190ZXN0X3RhYmxlKEZJTEUgKm91dGZw
KQogCWZwcmludGYob3V0ZnAsICJ9LFxuIik7CiB9CiAKK3N0YXRpYyB2b2lkIHByaW50X3N5
c3RlbV9ldmVudF9tYXBwaW5nX3RhYmxlX3ByZWZpeChGSUxFICpvdXRmcCkKK3sKKwlmcHJp
bnRmKG91dGZwLCAiXG5zdHJ1Y3QgcG11X3N5c19ldmVudHMgcG11X3N5c19ldmVudF90YWJs
ZXNbXSA9IHsiKTsKK30KKworc3RhdGljIHZvaWQgcHJpbnRfc3lzdGVtX2V2ZW50X21hcHBp
bmdfdGFibGVfc3VmZml4KEZJTEUgKm91dGZwKQoreworCWZwcmludGYob3V0ZnAsICJcblx0
e1xuXHRcdC50YWJsZSA9IDBcblx0fSwiKTsKKworCWZwcmludGYob3V0ZnAsICJcbn07XG4i
KTsKK30KKwogc3RhdGljIGludCBwcm9jZXNzX3N5c3RlbV9ldmVudF90YWJsZXMoRklMRSAq
b3V0ZnApCiB7CiAJc3RydWN0IHN5c19ldmVudF90YWJsZSAqc3lzX2V2ZW50X3RhYmxlOwog
Ci0JZnByaW50ZihvdXRmcCwgIlxuc3RydWN0IHBtdV9zeXNfZXZlbnRzIHBtdV9zeXNfZXZl
bnRfdGFibGVzW10gPSB7Iik7CisJcHJpbnRfc3lzdGVtX2V2ZW50X21hcHBpbmdfdGFibGVf
cHJlZml4KG91dGZwKTsKIAogCWxpc3RfZm9yX2VhY2hfZW50cnkoc3lzX2V2ZW50X3RhYmxl
LCAmc3lzX2V2ZW50X3RhYmxlcywgbGlzdCkgewogCQlmcHJpbnRmKG91dGZwLCAiXG5cdHtc
blx0XHQudGFibGUgPSAlcyxcblx0fSwiLAogCQkJc3lzX2V2ZW50X3RhYmxlLT5zb2NfaWQp
OwogCX0KLQlmcHJpbnRmKG91dGZwLCAiXG5cdHtcblx0XHQudGFibGUgPSAwXG5cdH0sIik7
CiAKLQlmcHJpbnRmKG91dGZwLCAiXG59O1xuIik7CisJcHJpbnRfc3lzdGVtX2V2ZW50X21h
cHBpbmdfdGFibGVfc3VmZml4KG91dGZwKTsKIAogCXJldHVybiAwOwogfQpAQCAtOTM4LDYg
Kzk0OSw5IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9lbXB0eV9tYXBwaW5nKGNvbnN0IGNoYXIg
Km91dHB1dF9maWxlKQogCWZwcmludGYob3V0ZnAsICIjaW5jbHVkZSBcInBtdS1ldmVudHMv
cG11LWV2ZW50cy5oXCJcbiIpOwogCXByaW50X21hcHBpbmdfdGFibGVfcHJlZml4KG91dGZw
KTsKIAlwcmludF9tYXBwaW5nX3RhYmxlX3N1ZmZpeChvdXRmcCk7CisJcHJpbnRfc3lzdGVt
X2V2ZW50X21hcHBpbmdfdGFibGVfcHJlZml4KG91dGZwKTsKKwlwcmludF9zeXN0ZW1fZXZl
bnRfbWFwcGluZ190YWJsZV9zdWZmaXgob3V0ZnApOworCiAJZmNsb3NlKG91dGZwKTsKIH0K
IAotLSAKMi4yNi4yCgo=
--------------F62C2E5729283149E21160D0--
