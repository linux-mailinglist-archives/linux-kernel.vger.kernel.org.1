Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0E279218
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgIYUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbgIYU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:28:35 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:08:15 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g44so2228457qtb.15
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Pg/q+cShJ2TCcjGxs7q4Fygizp/ROmQQAMr8hgsCOAg=;
        b=lS1I4C9ylGPj50X5ZPeUGgLS51MIIM2iBUzMY6DD9UQmNardDGYOGiAeayZ+g0BFgl
         UKrUAuGE9Q0rgJiPrBQo7sf6ywiZx72dTLp7wrh5PnXnixO+3fdEsvJ3mUMXITcGEfq0
         40pcEgC60/i/YuXS6n6JIMRSzDvkuwM7NcTaalCCANiBfemHSfpHhvbWlm0bAfZSvsYi
         512yluxM4RG6oe2cCYcBhAlmjlSwzUrNBWc/3nvtuQUM0RJ2sbx1hcRtrZ9Ysv4P/b4L
         pHF3uJ+59KtrkqXZRXjbVJS7DpIons07h9DA13WpJUtwLpYZJXXvsTRF44Q3QnWjtmj6
         7nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Pg/q+cShJ2TCcjGxs7q4Fygizp/ROmQQAMr8hgsCOAg=;
        b=rdDTnq75Jr1aYXiwxKmz/iWDOrQ4SYWWZzbQqATX839hhMiF7yYknUln7+Fg39Fksb
         KrhNACZmi2chDZZhODhgqOIKuWmu7lRJE5loSA7vqJyvoh8vmUQPjXMEjxXsl96p4m40
         zC/AxBrwxj5WIHJ3in/iuT6N53Ms1jYRPNNPEphB8fB9ZVoSQqoSaX8hhBskL0UuRPG4
         Hmp5YQF57ssqkKydUknYSjYX98m6FBY+6vHtz0lZXeN8p8gNV4f85LUF2hPOLJWyKwNl
         luxLUDlQRryhBSL9ly0Vmz9fCYlEz8uAjynVE3t82hIiZqEfnAf2fK1QoFVBYKAon6Ih
         Moxg==
X-Gm-Message-State: AOAM530Brhy3NqsiBemeHViVuCedByPIM4j6LhwUtMp8tr1G8VH6Mrr6
        9Ec4WCaIr1UXziSHEuThN25yJNIFToifLejn7Rke
X-Google-Smtp-Source: ABdhPJyUUgeTgqkC7Do+OGxgT/3xPizggt3i6QaTPCXPUs0AUte4gjvs0MbWsNZIVR8p3R7tYMyU5vQ958QZmpyWoF6G
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:5146:: with SMTP id
 g6mr85631qvq.22.1601060894265; Fri, 25 Sep 2020 12:08:14 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:08:05 -0700
Message-Id: <20200925190806.1870935-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [RFC PATCH 0/1] tracing: support dynamic string field types for
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

Hi Steven and Tom,

In this thread: https://lkml.org/lkml/2020/9/17/1015 we discussed how to plumb
dynamic strings into synthetic events. Tom, you proposed adding a new dynamic
string type to synthetic event definition like "char foo[]".

I'm sending this patch because it may be simpler than implementing that (I'm
not too familiar with the tracing infrastructure, apologies if this is not
true), and in my testing it seems sufficient to address my use case. I tested
both setting up a synthetic event as Steven described in the other thread, as
well as doing an analogous thing with a small bpftrace program, and both work as
expected with this patch.

This is because I happen to know there's an upper bound on the length of the
string in question, so I can just define a "char memcg_path[256]" in the
synthetic event, and I can be sure the string won't be truncated.

Let me know what you think. Happy to drop this and wait for Tom's suggested
approach instead.

Axel Rasmussen (1):
  tracing: support dynamic string field types for synthetic events

 kernel/trace/trace_events_hist.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--
2.28.0.681.g6f77f65b4e-goog

