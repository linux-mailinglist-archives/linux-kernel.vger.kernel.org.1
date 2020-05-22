Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861C31DDEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 06:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgEVE0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 00:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgEVE0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 00:26:14 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FE620756;
        Fri, 22 May 2020 04:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590121574;
        bh=QRgdBNMNjcFVUoXKdl3hj9Xt72k8VdT9khPNbWGOMsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJrnDFeeChTu0xnvQvWG69cMKjS7mIuWk6BHdBTJtvpFz5KPPakkbwgTQrGVVEsP6
         SyjD1JPZ8LE6dTGA3CNqgvZss5B37wuXNqEZkbVHH9gkWeUwNxIrd74g8MJh2zjt6W
         H9OFCZGYJs+2hEP1ovCFLLEPC+lbfBmnhuktrCWE=
Date:   Fri, 22 May 2020 06:26:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 06/14] docs: debugging-via-ohci1394.txt: add it to the
 core-api book
Message-ID: <20200522062607.143eb8d0@coco.lan>
In-Reply-To: <20200515120016.2083479c@lwn.net>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <9b489d36d08ad89d3ad5aefef1f52a0715b29716.1588345503.git.mchehab+huawei@kernel.org>
        <20200515120016.2083479c@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 15 May 2020 12:00:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri,  1 May 2020 17:37:50 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > There is an special chapter inside the core-api book about
> > some debug infrastructure like tracepoints and debug objects.
> > 
> > It sounded to me that this is the best place to add a chapter
> > explaining how to use a FireWire controller to do remote
> > kernel debugging, as explained on this document.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> I've applied this, but core-api really seems like the wrong place for
> this.  It would be good to rethink our layout a bit at some point in the
> near future...

Yeah, agreed. Debug functionality should likely deserve a separate
chapter outside core-api.

Now that we'll have all docs converted, it should be easier to view
the hole picture and re-design the doc organization.


Thanks,
Mauro
