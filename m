Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6429A367
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502084AbgJ0DlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:41:22 -0400
Received: from m1386.mail.163.com ([220.181.13.86]:24869 "EHLO
        m1386.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgJ0DlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:41:22 -0400
X-Greylist: delayed 2711 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 23:41:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=degAk
        vjFU9LhDFIP73HkGuhgdXIs+m3FWgbkTRFxfN0=; b=dPd68NqQ9iYqQ7jHeAIWH
        k+C1nu/NhtXSpfu46MsV+UUkYvPrfRiJ+1axx//+UXrecE8ulDErIFZn/mbvxocJ
        ljU5N1R3+rbOxwC4O0FR2xnJnkjx3BBHHck0OajLuS9JAH4fcobKwoCfBOeEJrOe
        CugJQgYbbCtN8Y02seN4g8=
Received: from sh_def$163.com ( [54.190.20.25] ) by ajax-webmail-wmsvr86
 (Coremail) ; Tue, 27 Oct 2020 10:07:47 +0800 (CST)
X-Originating-IP: [54.190.20.25]
Date:   Tue, 27 Oct 2020 10:07:47 +0800 (CST)
From:   =?GBK?B?y9W71A==?= <sh_def@163.com>
To:     "Steven Rostedt" <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] sched/rt.c: use list_is_singular() instead of
 '->prev != ->next'
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <20201026142956.0a429137@gandalf.local.home>
References: <20201026174152.GA10163@rlk>
 <20201026142956.0a429137@gandalf.local.home>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7d001f9c.1225.17567cfb5f0.Coremail.sh_def@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: VsGowACnVkDzgJdfOgZrAA--.48881W
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQjKX1UMWIuv5QACsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PlBlcmhhcHMgdGhlcmUgc2hvdWxkIGJlIGEgbGlzdF9oYXNfbW9yZV90aGFuX29uZSgpIEFQSSwg
YXMgbGlzdF9pc19zaW5ndWxhcgo+cmVxdWlyZXMgdHdvIGNoZWNrcywgYW5kIHRoZSAibW9yZV90
aGFuX29uZSIgb25seSByZXF1aXJlcyBhIHNpbmdsZSBjaGVjay4KPgo+bGlzdF9pc19zaW5ndWxh
cigpIGlzOgo+Cj4JCXJldHVybiAhbGlzdF9lbXB0eShsaXN0KSAmJiAobGlzdC0+bmV4dCA9PSBs
aXN0LT5wcmV2KTsKPgo+Cj53aGljaCBpcyBtb3JlIHdvcmsgdGhhbiB3aGF0IHlvdSBhcmUgcmVw
bGFjaW5nLgo+CgpIaSwgU3RldmU6CgpUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24uCk1heWJl
IHdlIHNob3VsZCBhZGQgYW5vdGhlciBhcGkgY2FsbGVkICJsaXN0X21vcmVfdGhhbl9vbmUiIGp1
c3Qgd2l0aG91dApsaXN0X2VtcHR5KCkgY2hlY2suCgpJIHdpbGwgc2VuZCBQQVRDSCBWMiBsYXRl
ci4KClRoYW5rLg==
