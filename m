Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3926E0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgIQQlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgIQQiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:38:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA182214D8;
        Thu, 17 Sep 2020 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600360691;
        bh=ZbFCcq9rxKOm2jqLy5LrwzzDX3URSfmspDs7nsDj/b4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCNJ+LLShql7CSA8MK8XMSJoU5yHqPOcvX8RSdZ+Uy3bucYkDG2A2umXzQ/ST1PV/
         /0LPrLjM8Pt6GJD9ZrU6VfiL5Ngoy4wpLfZs1Ataa/2ZcT5gCwDbo03z3Cigdp5rDI
         0KuJFk2+UryYS9MrZGDGM2ChDfW8zB+iEppMSgcM=
Date:   Thu, 17 Sep 2020 18:38:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 0/4] docs: fb: Removed framebuffer scrollback related
 documentations
Message-ID: <20200917163843.GA721081@kroah.com>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:56:11PM +0530, Bhaskar Chowdhury wrote:
> 
> In this patch series, documentation get in sync with the code removal
> of scrollback,by this commit 50145474f6ef ("fbcon: remove soft scrollback code"),
> by eliminating the information related to it.

Much nicer, thanks for sticking with it:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
