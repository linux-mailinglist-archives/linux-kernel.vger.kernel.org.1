Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089F120C71B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgF1Ira (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgF1Ira (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:47:30 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20809C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 01:47:30 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 49A2EC01A; Sun, 28 Jun 2020 10:47:28 +0200 (CEST)
Date:   Sun, 28 Jun 2020 10:47:13 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [PATCH] 9p: remove unused code in 9p
Message-ID: <20200628084713.GA10219@nautica>
References: <20200628074337.45895-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200628074337.45895-1-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Sun, Jun 28, 2020:
> These codes have been commented out since 2007 and lay in kernel
> since then. So, it's better to remove them.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

Thanks, queued for 5.9
-- 
Dominique
