Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27CA27D444
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgI2RQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:16:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:38010 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgI2RQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:16:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ECF932F2396;
        Tue, 29 Sep 2020 13:16:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NXkvv_s0ioF0; Tue, 29 Sep 2020 13:16:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C05A42F1D71;
        Tue, 29 Sep 2020 13:16:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C05A42F1D71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601399811;
        bh=tNoQqOpdjeC+qQwWWG9HdzwOkZ43A7lK46SV8L/pwKc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FoQ//3AZ3zPR7tF5OKMusmaUXPDem2vMak8kbxfP8elhn8K8mSxmb1u32O3946ni6
         /3Pwkb5o/uNMFniRDMQ4a39bjT8jDAyZmmAlL4Oozr0Up1gnsUpbuYMl4bvzWQMJSk
         pZBw2dj7XcdzCgz8KahtScv7XwBkXXd8NdsEu7MQrrLwGxL1nYneb1P9d3KPULu2xZ
         qF7rzAFTtPQhu6eg/a7pX6xaCsHEipx5C4N1dbRUFC+JXexeR+kh3IdBYJfS0RMCU8
         oPdrX03G6F2+3k91lZqvAj4w1qn1ilc8whkOT9rL3mKOg/guvCNF66CVvSpC1wq4ep
         bcfP71tb12S+g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d1-MQCtvbsox; Tue, 29 Sep 2020 13:16:51 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B52712F2191;
        Tue, 29 Sep 2020 13:16:51 -0400 (EDT)
Date:   Tue, 29 Sep 2020 13:16:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <939104894.187.1601399811707.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 0/3] Membarrier updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3968)
Thread-Topic: Membarrier updates
Thread-Index: vuiQtUuq2R+cU8cc7G4rv+G9QMkgZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 1:25 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Please find the following membarrier updates series posted as RFC.

Hi Peter,

I did not get any feedback on this round of RFC. Is it because it is perfect,
or because it is abysmally wrong ? :)

If it's good, then I'll post it without RFC tag.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
