Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B991D4EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEONO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 09:14:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:36482 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEONO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:14:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 07E3A2AEA37;
        Fri, 15 May 2020 09:14:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DrOXHsKpbP7f; Fri, 15 May 2020 09:14:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6D72E2AE8C3;
        Fri, 15 May 2020 09:14:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6D72E2AE8C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589548465;
        bh=LwT4tVtwPlfVmFfBUzcUpGUisDtsNgwRu0ORnXqgEQQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LUI/mAPiATIB3Ag4OcsnLnIV/URYnmxe84VmYDlp7jOCWHNr8OaklkWQQEVkQqSy4
         LXSHDthZYCjKXVYh7Arp5qP0/BRQKDSDWJSyGX+56Zj4ll/2ksRydcebeeTDt2r7c5
         CWSiIddHZSEb9puGLFsvcm054PfKEzWvo/iNuGZ7TDXDcB876REEJ46dDWifOH8Ygr
         5rT313/6QYLADuKDnNAoG6b8F/x1LvrnE21ee8NzYZ2t9NagUJunYY+BZYWlUm3Una
         H72XetsgZ6QvadSFFxmUkLfWgF9xoC6wCTPd3ltOA5Tid48v5fxcYtfAnhte93bYvC
         5AbUwmm2fAehg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Eeiplwiyk_46; Fri, 15 May 2020 09:14:25 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5F3C62AE772;
        Fri, 15 May 2020 09:14:25 -0400 (EDT)
Date:   Fri, 15 May 2020 09:14:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>
Message-ID: <899224070.22207.1589548465359.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200515124710.16439-1-laijs@linux.alibaba.com>
References: <20200515124710.16439-1-laijs@linux.alibaba.com>
Subject: Re: [PATCH 1/2] rbtree_latch: quit searching when reaching to
 maximum depth
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: rbtree_latch: quit searching when reaching to maximum depth
Thread-Index: YyqDBKzcltjMCM4/XhXkAEjQyhTcOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 15, 2020, at 8:47 AM, Lai Jiangshan laijs@linux.alibaba.com wrote:
[...]
> So the serarch should stop when diving down up to
> 2*BITS_PER_LONG depth.

serarch -> search

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
