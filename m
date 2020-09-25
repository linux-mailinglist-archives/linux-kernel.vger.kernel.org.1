Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C3279231
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgIYUe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgIYUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:33:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93276C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:08:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so2911550qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Pez5THOt05FrG4WaH1BvI+soz0Iv0kPDjI4rhwD4dik=;
        b=U65n5iLmDW7OPz4FbgxiMX8qcJn0/SiHVvnt4yBnlDPzZFLj+i8EkGMi62u2EHi03Z
         d0jV/jD9YWJtFjIAbZ5CAM1nfweaQq9C9NE5/7Uguw3i9UrtL/qIASEqxbE8O+EJUKVt
         9RVPfpwJ6JfJmz7YNgUvXYTJegsugrjK4dCy00Q4IP9cYqm1ErnFJwmmc7M1q+MwELBv
         ZqZ4JdrnzmA0SvdPf0wou8tZNxiV/pG1gEnoPBgddL7NLQz/JdlGXUNbwRwsAK6OMebl
         o+ADFSk1UKWEh52FEve1wTg+X62ooslPPquN2DTGVqKE3RHKwyAbhmS/H8y/aeTpK3LW
         OnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pez5THOt05FrG4WaH1BvI+soz0Iv0kPDjI4rhwD4dik=;
        b=q6PD+CP3WciiOvwlbA27D6M/8drKW7UQyhxzT/R+Q1M0wMNr516amKX+NZ8lIXYzSB
         drqr0g8ooaAmvYWqo1KVpJWIyllKPxMviD1zYiif7kmIjMQsmJRpgojVOKOgG9j5b6wh
         13jPi45LX/SW6qKTs4kcXwh6qkORuH0qzPJenneAYQ8+M8wZQM7QCGBmPx1+iyuKCqNZ
         nhsJSnJtUH5E9Tno1G4TC1z9pcBa74hgXeuo+N3WT4PS3+p+1gxFWWdooNP3V55i2GL4
         eMdZDmfthox4P7BLXZkG3np9Xu+XCqM6qXJ0K3Ki23kngeBUXBV00u8BNwanRMRVdNcT
         sTQw==
X-Gm-Message-State: AOAM533gPcAawwrALC+j/4PeLtLr2NadnPL72cfXVoUABYHdM4mwiX9X
        0u4DUIgNIuRYX6P45uCFgeL+ie0gcDH+RoCqM4ev
X-Google-Smtp-Source: ABdhPJwmc6jXSEO80L5AyLR0vfbRmUSY4ODyZKDceffIeWs4vjSPUkfOuCSvKTz1bA6UAcP/pJVKY+xPfMDWHarQw73v
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:c244:: with SMTP id
 w4mr95785qvh.12.1601060896752; Fri, 25 Sep 2020 12:08:16 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:08:06 -0700
In-Reply-To: <20200925190806.1870935-1-axelrasmussen@google.com>
Message-Id: <20200925190806.1870935-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20200925190806.1870935-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [RFC PATCH 1/1] tracing: support dynamic string field types for
 synthetic events
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's typical [1] to define tracepoint string fields as "const char *",
using the __string, __assign_str, and __get_str helpers. For synthetic
event definitions, the only available mechanism to define a string type
is a fixed-size char array ("char[]") [2].

Without this patch, since the type strings aren't identical, and the
sizes don't match (since one is an array, and the other is a "dynamic
string" integer), they are considered incompatible [3].

This patch modifies that check, so as to let us setup synthetic events,
and plumb through string values from typical tracepoints. It turns out
this is already handled correctly, as long as the check during
definition parsing doesn't prevent it.

[1] grep -r "__string" include/trace/events/
[2] See synth_field_is_string in kernel/trace/trace_events_synth.c
[3] See check_synth_field in kernel/trace/trace_events_hist.c

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 kernel/trace/trace_events_hist.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0b933546142e..e064feb3cc65 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3280,9 +3280,18 @@ static int check_synth_field(struct synth_event *event,
 	field = event->fields[field_pos];
 
 	if (strcmp(field->type, hist_field->type) != 0) {
-		if (field->size != hist_field->size ||
-		    field->is_signed != hist_field->is_signed)
-			return -EINVAL;
+		/*
+		 * If both are kinds of strings, they match. We can't use
+		 * is_string_field for the hist_field, as it's only sort of
+		 * partially initialized at this point.
+		 */
+		if (strstr(field->type, "char[") == NULL ||
+		    strstr(hist_field->type, "char[") == NULL) {
+			/* They still match if size and signedness match. */
+			if (field->size != hist_field->size ||
+			    field->is_signed != hist_field->is_signed)
+				return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.28.0.681.g6f77f65b4e-goog

