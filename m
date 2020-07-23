Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5B22B123
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgGWOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 10:20:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgGWOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:20:26 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595514024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSo/4VWDW4CMWU0h3PQvI5YPDGHrTnQn4D7hetc67Eg=;
        b=WUTsHGNHI/kUYiHTcX4Cg84Y56n8X8+NEFYv0vB3PJbsEcfls6i/YIqNlkFk+iCukQ5ImF
        xPyPT05ywGsgFUlA0/cALfT35Qs3TwOzi+513dE4v/ax6GFJbNzABXti/a5RJS00Qq1HTn
        UBKnEN+RKfpr9UTqnS5UFhh2/CAfSk/1kTnczIBmP/bh3iGzWq7N1YqJaBeqlfwI9Ulk+X
        p0EGdVqb1VjPpIqmukXiqtmcmFcC7iGgufnZgXdIYpob+SN/KURBUrcQbNpMh5aWSusto4
        4PX6WxYShlGFirJ5iy/ngU9fK4ttCBZFXsSKlASRuEiWi4JBNZXPRPLsGve4cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595514024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSo/4VWDW4CMWU0h3PQvI5YPDGHrTnQn4D7hetc67Eg=;
        b=YNZsXb2uiLHiS8cezCAimIfsNCBLXzqYhOjomDEGtzIw0evBpxSfknll6VNOU77aAn1onu
        ugX8nyuvZGF8s0BA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com, kernel@axis.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
In-Reply-To: <87blk6cosb.fsf@jogness.linutronix.de>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com> <20200721173045.540ae500@oasis.local.home> <87eep3zmg9.fsf@jogness.linutronix.de> <20200722112525.694880d3@oasis.local.home> <87blk6cosb.fsf@jogness.linutronix.de>
Date:   Thu, 23 Jul 2020 16:26:23 +0206
Message-ID: <878sfacnyw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-23, John Ogness <john.ogness@linutronix.de> wrote:
> For me a trace event represents a specific point in the kernel
> code.

Actually, after revisiting Vincent's original patch (adding a "dynamic"
event in the "printk" group and placing the event within the
dynamic_printk printing path), I would fully support the new event. It
_is_ appropriately a printk/dynamic event.

John Ogness
