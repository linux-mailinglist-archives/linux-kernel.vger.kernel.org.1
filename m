Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735BD2A227D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 01:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKBACE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 19:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKBACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 19:02:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA8C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=0zEKYXveXP5fa+tRFUARog0gdVdEjUSFs0ihOqFPpjc=; b=uJXtK9JNCoVw/IsdTE5SFtOBT9
        OY+TlKxuHR9FV3v7/e/bMVddI9hFnaDogVMwsZlcBCcRw9uTUl4ML6tJPYGijYGW0QlWEUFKM2NIg
        WeNVX2Bs0+oubNRt3WLBVjIjrsoBVyFU/y/oCk/ztPHsP8IqIB7aaHXba28HMzgY3BzmwtOZivmAP
        rZdvd6PWuM3r/Y83yR+EdjPJLI+21n00U0bBncT/KITtFtlNhR4/nzxmRIeb6r61BdBrEhFrLESzu
        uCb3sVWJCC5+g2G0gA88gpqtzXCG5j3d9EYSmH/6htJ/DS+VH2xjJ5s6Jz304ASkUwxsrUebwxKoF
        2F8l7VkQ==;
Received: from [2601:1c0:6280:3f0::60d5]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZNIN-0004it-AO; Mon, 02 Nov 2020 00:01:59 +0000
Subject: Re: Linux 5.10-rc2 (docs build)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
Date:   Sun, 1 Nov 2020 16:01:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Something broke the docs build (SEVERE):


Sphinx parallel build error:
docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:

Attributes Common for All RapidIO Devices
-----------------------------------------


and then it stops/hangs. Does not terminate normally but is no longer
executing.

-- 
~Randy

