Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE22AEAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKKISH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:18:07 -0500
Received: from verein.lst.de ([213.95.11.211]:39196 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgKKISD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:18:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 966BD6736F; Wed, 11 Nov 2020 09:18:00 +0100 (CET)
Date:   Wed, 11 Nov 2020 09:18:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
Message-ID: <20201111081800.GA23492@lst.de>
References: <20201029101432.47011-3-hch@lst.de> <20201111022122.1039505-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111022122.1039505-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:21:22PM -0800, Nick Desaulniers wrote:
> Sorry, I think this patch may be causing a regression for us for s390?
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/432129279#L768
> 
> (via https://lore.kernel.org/linux-mm/20201029101432.47011-3-hch@lst.de)

Hmm, the call to follow_pte_pmd in the s390 code does not actually exist
in my tree.
