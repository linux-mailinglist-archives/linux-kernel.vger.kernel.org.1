Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3A21B3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGJLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 07:09:07 -0400
Received: from nautica.notk.org ([91.121.71.147]:53271 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJLJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:09:07 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 2F266C009; Fri, 10 Jul 2020 13:09:05 +0200 (CEST)
Date:   Fri, 10 Jul 2020 13:08:50 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [PATCH v4] 9p: retrieve fid from file when file instance exist.
Message-ID: <20200710110850.GB17924@nautica>
References: <20200710101548.10108-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710101548.10108-1-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Fri, Jul 10, 2020:
> In the current setattr implementation in 9p, fid is always retrieved
> from dentry no matter file instance exists or not. If so, there may be
> some info related to opened file instance dropped. So it's better
> to retrieve fid from file instance when it is passed to setattr.
> 
> for example:
> fd=open("tmp", O_RDWR);
> ftruncate(fd, 10);
> 
> The file context related with the fd will be lost as fid is always
> retrieved from dentry, then the backend can't get the info of
> file context. It is against the original intention of user and
> may lead to bug.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---


For next time, you can add arbitrary comments (e.g. describe briefly
differences from previous versions) after the --- line.

For others, this inits fid to NULL in both functions; thanks for picking
it up I'll refresh the patch.

-- 
Dominique
