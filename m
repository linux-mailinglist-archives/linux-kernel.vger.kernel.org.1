Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBC2136D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGCI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:58:54 -0400
Received: from nautica.notk.org ([91.121.71.147]:51096 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGCI6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:58:54 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C3C1DC01E; Fri,  3 Jul 2020 10:58:52 +0200 (CEST)
Date:   Fri, 3 Jul 2020 10:58:37 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [PATCH v3] 9p: retrieve fid from file when file instance exist.
Message-ID: <20200703085837.GA3857@nautica>
References: <20200703082018.8160-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703082018.8160-1-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Fri, Jul 03, 2020:
> In the current setattr implementation in 9p, fid is always retrieved
> from dentry no matter file instance exists or not. Thus, there may be
> some info related to opened file instance dropped. So it's better
> to retrieve fid from file instance when it has passed to setattr.
> 
> for example:
> fd=open("tmp", O_RDWR);
> ftruncate(fd, 10);
> 
> The file context related with the fd will be lost as fid is
> retrieved from dentry, then the backend can't get the info of
> file context. It is against the original intention of user and
> may lead to bug.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

ACK.
I've picked this up for tests, will push to linux-next when I finally
manage to find time for these...

-- 
Dominique
