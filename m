Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47AE1B04C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDTIq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:46:59 -0400
Received: from verein.lst.de ([213.95.11.211]:39427 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:46:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A83B68C4E; Mon, 20 Apr 2020 10:46:56 +0200 (CEST)
Date:   Mon, 20 Apr 2020 10:46:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hide __pte2cachemode_tbl and __cachemode2pte_tbl
Message-ID: <20200420084656.GA1229@lst.de>
References: <20200408152745.1565832-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408152745.1565832-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:27:41PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series avoids pointlessly exposing the cachemode to pte bit
> translation tables to modules.

Any comments?
