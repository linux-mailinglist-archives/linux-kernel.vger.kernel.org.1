Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A66277F18
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 06:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIYEhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 00:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgIYEhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 00:37:19 -0400
Received: from coco.lan (ip5f5ad5bf.dynamic.kabel-deutschland.de [95.90.213.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1C020888;
        Fri, 25 Sep 2020 04:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601008639;
        bh=3EVUiepKXd96fe5LeoL320sa23usfSSfETrG33UhF5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SBsyzwD1bpopnkh8paY9VNFWFEHnbsHTqbdSp09/mf6m042OECNqEfOA6Rit1HZXC
         RfkTa5XNd2PpfufDn3Z1nXhXGskc+1aus5foX5Qa3EmtZOzeLr16o1h/CkiU+q3Sic
         Ingo51YbKni3C9HPH+Rm2syGd0Xzx3fxC37Z7di8=
Date:   Fri, 25 Sep 2020 06:37:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] docs: cdomain.py: add support for two new Sphinx
 3.1+ tags
Message-ID: <20200925063715.047cc585@coco.lan>
In-Reply-To: <20200924102439.18f95779@lwn.net>
References: <cover.1600963096.git.mchehab+huawei@kernel.org>
        <64f6f8bc4c416bcf1a6439529346ec6cbcf34ac1.1600963096.git.mchehab+huawei@kernel.org>
        <20200924102439.18f95779@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 24 Sep 2020 10:24:39 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Thu, 24 Sep 2020 18:21:45 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > As part of changing the documentation subsystem to properly
> > build with Sphinx 3.1+, add support for two tags:
> > 
> > 	- :c:expr:`foo`
> > 	- .. c:namespace::"  
> 
> So is there a reason we need :c:expr: ?  What does it add for us?

Good point. This came from a suggestion from the Sphinx issue.

The :c:expr: actually helped to identify two wrong declarations at the
DVB uAPI docs[1] but in practice it doesn't do much, except
by using a different font like placing "struct" in italics.

I was expecting it to also create cross-references to the structs
mentioned there, but, at least on my tests, it didn't work like that.

Anyway, I guess we can just get rid of it.

I'll send a v3 series without that.

Thanks,
Mauro
