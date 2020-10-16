Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF62728FEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404320AbgJPG4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394357AbgJPG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:56:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6207CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 23:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYM5G+dttTgthRfiyRZGB6ieggpXe3r70jfnD17DcHA=; b=cdWToJTeEIuE6QqdvcKPWex0o3
        QOahBMYsFdJoT/fb5G5xvV1bSsYWWsEJIlY7cVoVbnL/qIye7jO+PErDlfU5fIjocg+iYPqolY3UO
        wrI+uvTBxZ/2aIADqVwwQt+FiH2cQr8bEqycZwhEo7TjDjIR1NEa/Q0gjD5JW866eVnTUb7McVGpN
        354AfcQIz1KciaQhSmMUqxLN4lUE8Tq/aUd3oJM+mjZokBTSWLixN8CjPk1adTEzp0sA4vSqqXlk8
        O+FuX2NN9vhBpTf+6v8krO1CpuDtlwC41+gWxWk/vwpEyPDbpYrFZi54Od5ymA3gEOVTRalPN7vgq
        aFFk0Svg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTJey-0002h5-4I; Fri, 16 Oct 2020 06:56:16 +0000
Date:   Fri, 16 Oct 2020 07:56:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Christopher M. Riedl" <cmr@codefail.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH 3/8] powerpc: Mark functions called inside uaccess blocks
 w/ 'notrace'
Message-ID: <20201016065616.GB9343@infradead.org>
References: <20201015150159.28933-1-cmr@codefail.de>
 <20201015150159.28933-4-cmr@codefail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015150159.28933-4-cmr@codefail.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:01:54AM -0500, Christopher M. Riedl wrote:
> Functions called between user_*_access_begin() and user_*_access_end()
> should be either inlined or marked 'notrace' to prevent leaving
> userspace access exposed. Mark any such functions relevant to signal
> handling so that subsequent patches can call them inside uaccess blocks.

I don't think running this much code with uaccess enabled is a good
idea.  Please refactor the code to reduce the criticial sections with
uaccess enabled.

Btw, does powerpc already have the objtool validation that we don't
accidentally jump out of unsafe uaccess critical sections?
