Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485A1B3074
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDUTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgDUTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:35:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC7CC0610D5;
        Tue, 21 Apr 2020 12:29:48 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F84F823;
        Tue, 21 Apr 2020 19:29:48 +0000 (UTC)
Date:   Tue, 21 Apr 2020 13:29:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] Documentation: admin-guide: sysctl/kernel: fix
 headings format and underlines
Message-ID: <20200421132947.309356fe@lwn.net>
In-Reply-To: <5a343483-c896-ffd8-7a06-024e04f69053@infradead.org>
References: <5a343483-c896-ffd8-7a06-024e04f69053@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 10:25:34 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix underline length warnings and drop the ending semi-colon from the
> title so that they match other title lines.
> 
> linux-next-20200420/Documentation/admin-guide/sysctl/kernel.rst:281: WARNING: Title underline too short.
> 
> hung_task_all_cpu_backtrace:
> ================
> 
> linux-next-20200420/Documentation/admin-guide/sysctl/kernel.rst:564: WARNING: Title underline too short.
> 
> oops_all_cpu_backtrace:
> ================
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

So this one fixes a linux-next issue introduced by patch 93a0fba3de9a,
which went in via Andrew Morton's tree.  So I can't apply it; I think it
needs to go to akpm.

Thanks,

jon
