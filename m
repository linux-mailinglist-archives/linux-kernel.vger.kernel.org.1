Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8B285FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgJGNIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:08:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49803 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgJGNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:08:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kQ9BO-0000K6-C1; Wed, 07 Oct 2020 13:08:38 +0000
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: tracing: Add support for dynamic strings to synthetic events
Message-ID: <d34dccd5-96ba-a2d9-46ea-de8807525deb@canonical.com>
Date:   Wed, 7 Oct 2020 14:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with Coverity has detected a duplicated condition in an
if statement in the following commit in source
kernel/trace/trace_events_synth.c

commit bd82631d7ccdc894af2738e47abcba2cb6e7dea9
Author: Tom Zanussi <zanussi@kernel.org>
Date:   Sun Oct 4 17:14:06 2020 -0500

    tracing: Add support for dynamic strings to synthetic events

Analysis is as follows:

493        for (i = 0; i < event->n_fields; i++) {

Same on both sides (CONSTANT_EXPRESSION_RESULT)
pointless_expression: The expression event->fields[i]->is_dynamic &&
event->fields[i]->is_dynamic does not accomplish anything because it
evaluates to either of its identical operands, event->fields[i]->is_dynamic.

   Did you intend the operands to be different?

494                if (event->fields[i]->is_dynamic &&
495                    event->fields[i]->is_dynamic)
496                        pos += snprintf(buf + pos, LEN_OR_ZERO,
497                                ", __get_str(%s)",
event->fields[i]->name);
498                else
499                        pos += snprintf(buf + pos, LEN_OR_ZERO,
500                                        ", REC->%s",
event->fields[i]->name);
501        }

Colin
