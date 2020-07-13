Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1721B39A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGJLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:05:54 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186BDC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 04:05:54 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5DFF1C009; Fri, 10 Jul 2020 13:05:51 +0200 (CEST)
Date:   Fri, 10 Jul 2020 13:05:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
Message-ID: <20200710110536.GA17924@nautica>
References: <20200615012153.89538-1-zhengbin13@huawei.com>
 <20200615102053.GA11026@nautica>
 <ae01f0bd-da0a-f01f-cbd0-3af10ccaa4ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae01f0bd-da0a-f01f-cbd0-3af10ccaa4ae@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhengbin (OSKernel) wrote on Thu, Jul 09, 2020:
> Is this OK? I don't see it on linux-next

Yes, I just (still) haven't tested them, sorry.
It's in git://github.com/martinetd/linux branch 9p-test

-- 
Dominique
