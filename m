Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FF252A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHZJmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:42:07 -0400
Received: from foss.arm.com ([217.140.110.172]:43552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgHZJmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:42:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CFDA101E;
        Wed, 26 Aug 2020 02:42:05 -0700 (PDT)
Received: from [10.57.5.66] (unknown [10.57.5.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EDDB3F66B;
        Wed, 26 Aug 2020 02:42:05 -0700 (PDT)
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
From:   Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf inject: correct event attribute sizes
Message-ID: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
Date:   Wed, 26 Aug 2020 10:42:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf inject reads a perf.data file from an older version of perf,
it writes event attributes into the output with the original size field,
but lays them out as if they had the size currently used. Readers see
a corrupt file. Update the size field to match the layout.

From: Denis Nikitin <denik@google.com>
Signed-off-by: Al Grant <al.grant@foss.arm.com>

  tools/perf/util/header.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9cf4efdcbbbd..762eb94bd532 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3326,6 +3326,14 @@ int perf_session__write_header(struct
perf_session *session,
         attr_offset = lseek(ff.fd, 0, SEEK_CUR);

         evlist__for_each_entry(evlist, evsel) {
+               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
+                       /*
+                        * We are likely in "perf inject" and have read 
+                        * from an older file. Update attr size so that
+                        * reader gets the right offset to the ids.
+                        */
+                       evsel->core.attr.size = sizeof(evsel->core.attr);
+               }
                 f_attr = (struct perf_file_attr){
                         .attr = evsel->core.attr,
                         .ids  = {
