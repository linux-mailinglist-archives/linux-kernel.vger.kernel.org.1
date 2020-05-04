Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1128C1C46F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEDTWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 15:22:31 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:40090 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgEDTWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:22:31 -0400
To:     <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
From:   Thomas Backlund <tmb@mageia.org>
Subject: perf build error with gcc 10 on arm and aarch64
Message-ID: <2869c4f6-9adf-3d55-a41d-a42865ae56f2@mageia.org>
Date:   Mon, 4 May 2020 22:22:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is building perf from kernel-5.6.10 on armv7hl and aarch64:

Compiler is gcc 10.1.0-RC


   LD       perf-in.o
ld: arch/perf-in.o: in function `.LANCHOR0':
/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118: 
multiple definition of `traceid_list'; 
util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/cs-etm.h:118: 
first defined here
make[3]: *** 
[/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/build/Makefile.build:145: 
perf-in.o] Error 1

   LD       perf-in.o
ld: 
arch/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118: 
multiple definition of `traceid_list'; 
util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/cs-etm.h:118: 
first defined here
make[3]: *** 
[/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/build/Makefile.build:145: 
perf-in.o] Error 1
make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
make[1]: *** [Makefile.perf:225: sub-make] Error 2
make: *** [Makefile:70: all] Error 2


The same build succeeds with gcc 9.3.0

--


Thomas
