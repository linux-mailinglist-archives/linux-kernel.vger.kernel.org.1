Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8751D588A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOSAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 14:00:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:53664 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgEOSAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:00:18 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D477845;
        Fri, 15 May 2020 18:00:17 +0000 (UTC)
Date:   Fri, 15 May 2020 12:00:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Message-ID: <20200515120016.2083479c@lwn.net>
In-Reply-To: <9b489d36d08ad89d3ad5aefef1f52a0715b29716.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <9b489d36d08ad89d3ad5aefef1f52a0715b29716.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:50 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There is an special chapter inside the core-api book about
> some debug infrastructure like tracepoints and debug objects.
> 
> It sounded to me that this is the best place to add a chapter
> explaining how to use a FireWire controller to do remote
> kernel debugging, as explained on this document.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I've applied this, but core-api really seems like the wrong place for
this.  It would be good to rethink our layout a bit at some point in the
near future...

Thanks,

jon
