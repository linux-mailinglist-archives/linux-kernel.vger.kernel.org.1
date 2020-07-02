Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF9211D97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgGBH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 03:56:44 -0400
Received: from nautica.notk.org ([91.121.71.147]:34302 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgGBH4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:56:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 46763C021; Thu,  2 Jul 2020 09:56:42 +0200 (CEST)
Date:   Thu, 2 Jul 2020 09:56:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Justin He <Justin.He@arm.com>,
        Wei Chen <Wei.Chen@arm.com>
Subject: Re: [PATCH v2] 9p: retrieve fid from file when file instance exist.
Message-ID: <20200702075627.GA23996@nautica>
References: <20200701023821.5387-1-jianyong.wu@arm.com>
 <20200701105927.GA20762@nautica>
 <HE1PR0802MB25552E53839BA81FB26210ABF46D0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <HE1PR0802MB25552E53839BA81FB26210ABF46D0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Thu, Jul 02, 2020:
> Yeah, should check fid before "v9fs_fid_lookup", how about
> 
> if (iattr->ia_valid & ATTR_FILE) {
>                 fid = iattr->ia_file->private_data;
>                 WARN_ON(!fid);
>  }
> If (!fid)
> fid = v9fs_fid_lookup(dentry);

Yes, that would be fine.

-- 
Dominique
