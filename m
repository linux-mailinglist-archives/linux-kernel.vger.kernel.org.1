Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B22F1EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390770AbhAKTLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:11:32 -0500
Received: from mail.efficios.com ([167.114.26.124]:60286 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390621AbhAKTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:11:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 92E68242708;
        Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5fIU6ltaWmJh; Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6962A2424E3;
        Mon, 11 Jan 2021 14:10:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6962A2424E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1610392250;
        bh=9JVaWje3ptDlQarmNSm8HaoAAamJjX42E76uz2J9ek4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZUUXQqtgC4Vb9YKqBxdX4S2xMZ2OP9NO1FYOpP6zCKqCFdseW3u5fBcYBIBlwzwNQ
         Kh6XGdkcIruy+1LslQ1CP1t3zflHegnrw+tfj90R9FIAEbCRQdBDcKLWCWbCd14s4L
         TKZAd6WCD3Lr7VbLv3nZ17jhkXutpcnkq/QjOXmxli6XjpdzzC8jGwhZ51fNc8oE9O
         PSGJokkCNqMHaUsX4MzgGjSGH69fp4O29GJeRf4A5qq1ab0N8yzt0RrYt/u1/QIuXb
         lzZo6MyitSHIFBGeUA3PjrcPWblYvXbR0SGCZqQgnU5c170L9J0MwaoOteokJ29KKz
         7J22ml1EaLXtQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2IORqxS2zhVi; Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5E3BA2424E2;
        Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Date:   Mon, 11 Jan 2021 14:10:50 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <897024476.10469.1610392250359.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.7 and 2.12.4 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Index: 5m5q9JQ/0U77YrT12Q0xQhrp1t7WVA==
Thread-Topic: LTTng-modules 2.11.7 and 2.12.4 (Linux kernel tracer)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just released versions 2.11.7 and 2.12.4 of the lttng-modules stable branches.
These add support for the 5.10 Linux kernel.

Please try them out, and, as usual, feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
