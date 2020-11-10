Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349C22ADE42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgKJS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:26:22 -0500
Received: from verein.lst.de ([213.95.11.211]:36930 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731085AbgKJS0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:26:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBEC367373; Tue, 10 Nov 2020 19:26:18 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:26:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: simplify follow_pte a bit
Message-ID: <20201110182618.GA29611@lst.de>
References: <20201029101432.47011-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029101432.47011-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:14:30AM +0100, Christoph Hellwig wrote:
> Hi Andrew,
> 
> this small series drops the not needed follow_pte_pmd exports, and
> simplifies the follow_pte family of functions a bit.

any comments?
