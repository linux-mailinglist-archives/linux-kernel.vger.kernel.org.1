Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9529000A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394669AbgJPIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394533AbgJPIj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:39:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050DFC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 01:39:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so1073919pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 01:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOQoOAZUDHpcUncJgxnxM2Jw3xEiUcKHa7EZVIA2/KY=;
        b=AfeeXMXyOFoWs5rfmfRajUGzRsAFGVsAA/Gm++BDufUn+gVueuzC9L69OGUVMZsDHA
         hef9tacKJTPQYY1PNrpSG3g2TrG0Lhipn7hh69qT8FpHcp41Pkf5OWQt2t6D7QQbXakQ
         /7qZeMGngPhg/y26dwUhhOWUfSPEleGFL2O5cSwGergDj3JInvTJtraVAvQ+3p/STt9Z
         8g3rTVCUGpa0iV7AJAdiTIbfDYZlBAvsPlA0/Y9atJ7okw5NG3AmaA3TT8Oso1wvNt5a
         fxpdtdi3od/KfPajvP00zYspH+82jDgw3eM/2zwfDsXST1iWMOWf1NFfj2JCh4J+92kl
         /JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOQoOAZUDHpcUncJgxnxM2Jw3xEiUcKHa7EZVIA2/KY=;
        b=QuZ8stOw4yPyyQ3XticPZAs2EqbxEUjUWxXATijII8ibkOZ+MaIU40cTuZoPlu6dyd
         8/DA/jaSo1pcX/l+sOuoWbMfJsQRF8mm9lhfhkiCgYSP8/ItGzssOsac3wRG36WES1vJ
         PsAve7CuUQkXeacLKhD4EvJe880nhp2Xd6S1MgE60qMClMsqWX857LPKuwWNe9lbI47G
         9vPosctsJP0pfuX5CMXYXOg4SX2/6zSbzUDOebfybaXw9lAtETc1IrhFG6zyNgUVH973
         s9PBaelYMs0rqbmlKIUsTI8e9PJeIq88t5Em/vneBB+bxQ0HQpcuCRGUpYxhQSwx5Yab
         GOEw==
X-Gm-Message-State: AOAM530e3bMdnPYAI0TLd3lwZ16hVnv26v6CLLiFU388S2lpnog9tv2H
        Fg8cS4dNvTbYGOzWp6nAiKOz2w==
X-Google-Smtp-Source: ABdhPJzCXwVXYAwp16Dlkk8/x6p+3Cy3jEcFR6m+PNEsA7BzP+RsUV77M3ev3md1fXDOhCjEfftfrA==
X-Received: by 2002:a17:902:684b:b029:d5:a3a0:3b47 with SMTP id f11-20020a170902684bb02900d5a3a03b47mr2976376pln.76.1602837568269;
        Fri, 16 Oct 2020 01:39:28 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id js21sm2038954pjb.14.2020.10.16.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 01:39:27 -0700 (PDT)
Date:   Fri, 16 Oct 2020 08:39:23 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 2/4] block: add private field to struct keyslot_manager
Message-ID: <20201016083923.GA134672@google.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-3-satyat@google.com>
 <20201016071941.GA14885@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016071941.GA14885@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:19:41AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 09:46:30PM +0000, Satya Tangirala wrote:
> > Add a (void *) pointer to struct keyslot_manager that the owner of the
> > struct can use for any purpose it wants.
> > 
> > Right now, the struct keyslot_manager is expected to be embedded directly
> > into other structs (and the owner of the keyslot_manager would use
> > container_of() to access any other data the owner needs). However, this
> > might take up more space than is acceptable, and it would be better to be
> > able to add only a pointer to a struct keyslot_manager into other structs
> > rather than embed the entire struct directly. But container_of() can't be
> > used when only the pointer to the keyslot_manager is embded. The primary
> > motivation of this patch is to get around that issue.
> 
> No, please don't bloat the structure.  If some weird caller doesn't
> like the embedding it can create a container structure with the
> blk_keyslot_manager structure and a backpointer.
Ah, ok. Thanks!
