Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79882D7560
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405405AbgLKMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389830AbgLKMNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:13:36 -0500
Date:   Fri, 11 Dec 2020 13:14:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607688776;
        bh=265jhaKYi5ZUC7l3KnGWfOCzdtuq4U4HaVxv8zpsB1I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7QGyIxQcpNHf4QqxrhJkWnsEPMLaU9VTr4pRQEiYf54ialMhnwcHtwnlzUWulnYL
         e8m+k1pdw+jLU8dFD7BLo6Q+4tUFHOL7hnrrbClNj4r0yl0sMl7k76MTN/8hQkgnLk
         nlHfkyezpa56+09VXxfVZCTgmNzL6OwqmybY1lts=
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Kelly, Seamus" <seamus.kelly@intel.com>
Cc:     Joe Perches <joe@perches.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: Re: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
Message-ID: <X9NikKO55TEBODJP@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-17-mgross@linux.intel.com>
 <d33f6b90d50feb6c05bd45ffdedf3fb6d5ceb5ee.camel@perches.com>
 <BYAPR11MB37839DDCA13DC55E594F5D108ACA0@BYAPR11MB3783.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB37839DDCA13DC55E594F5D108ACA0@BYAPR11MB3783.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:33:02AM +0000, Kelly, Seamus wrote:
> This e-mail and any attachments may contain confidential material for the sole
> use of the intended recipient(s). Any review or distribution by others is
> strictly prohibited. If you are not the intended recipient, please contact the
> sender and delete all copies.

Now deleted!

This footer is incompatible with Linux kernel development, please remove
it in order for us to read your emails and do anything with them.

I can't believe that Intel still has this problem, after all of these
years...

greg k-h
