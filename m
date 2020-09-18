Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC226F961
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:34:57 -0400
Received: from nautica.notk.org ([91.121.71.147]:47793 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIRJe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:34:57 -0400
X-Greylist: delayed 12920 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 05:34:56 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 62839C01D; Fri, 18 Sep 2020 11:34:55 +0200 (CEST)
Date:   Fri, 18 Sep 2020 11:34:40 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Message-ID: <20200918093440.GA1877@nautica>
References: <HE1PR0802MB255594D67D97733CFDFE777EF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <HE1PR0802MB25555E7AAFA66DA3FE025D0AF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <20200914083200.GA9259@nautica>
 <HE1PR0802MB255560720A13BD59C11DEA00F43F0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <HE1PR0802MB255560720A13BD59C11DEA00F43F0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Fri, Sep 18, 2020:
> If we move the counter decrease code into p9_client_clunk and put it
> instead of fid_atomic_dec, we need delete fid off the inode where it
> stores in p9_client_clunk.
> But there is no way can we acquire the inode in p9_client_clunk. Do
> you have any idea? I think introduce another parameter for
> p9_client_clunk
> Is not graceful.

You cannot write code about the inode in p9_client_clunk, the way the
code is split fs/9p can refer to net/9p but not the other way around
(module-wise, 9p can refer to 9pnet but 9pnet cannot refer to 9p or we
would have cyclic dependencies)

However I don't see what bothers you.
v9fs_dir_release can remove the fid from the inode as it does currently
and just clunk immediately afterwards.


If another user of the fid had gotten the fid from the inode previously,
it has a ref, so the fid will not be actually clunked then but it will
be clunked later when it is done being used -- that is perfectly fine ?

p9_client_clunk should not have to worry about anything in the vfs.

-- 
Dominique
