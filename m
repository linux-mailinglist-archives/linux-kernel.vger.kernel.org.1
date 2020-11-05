Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD32A8127
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgKEOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgKEOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:44:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:44:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B1C9A1F46471;
        Thu,  5 Nov 2020 14:44:24 +0000 (GMT)
Date:   Thu, 5 Nov 2020 15:44:21 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Thirumalesha N <nthirumalesha7@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spinand: micron: add support for MT29F2G01AAAED
Message-ID: <20201105154421.686e0675@collabora.com>
In-Reply-To: <CALKVOUrf6J8Ke-fqv8SuTGMdWf+FDD8yK2RmZ2AtT9KUrJE_Xg@mail.gmail.com>
References: <20201103145901.29372-1-nthirumalesha7@gmail.com>
        <20201103160309.772f3538@collabora.com>
        <CALKVOUrf6J8Ke-fqv8SuTGMdWf+FDD8yK2RmZ2AtT9KUrJE_Xg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 23:18:54 +0800
Thirumalesha N <nthirumalesha7@gmail.com> wrote:

> Hi Boris,
> 
> On Tue, Nov 3, 2020 at 11:03 PM Boris Brezillon <
> boris.brezillon@collabora.com> wrote:  
> 
> > On Tue,  3 Nov 2020 22:59:01 +0800
> > Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote:
> >  
> > > The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
> > > ECC
> > >
> > > Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> > > ---
> > >
> > > v5: As per the review comments, the changes were reverted to the v2,
> > > except the MT29F2G01AAAED device related (including the review comments)  
> >
> > I don't think that's what Miquel suggested, especially not for the
> > {write,update,write}_cache_variants helpers.
> >  
> 
> 
> I was a bit confused with the multiple levels of comments with the previous
> patch and I renamed *{write,update,write}_cache_var**iants* to *micron_4_**
> to avoid function redefinition.
> Please can you direct me with this patch, what needs to be modified/renamed
> ?

Keep the SPINAND_OP_VARIANTS() as they were in v4 and use the micron_4_
prefix for ECC related stuff.
