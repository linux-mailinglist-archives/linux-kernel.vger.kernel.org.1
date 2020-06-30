Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9824E20F873
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbgF3Peo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 11:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbgF3Peo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:34:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4698A2074F;
        Tue, 30 Jun 2020 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593531283;
        bh=naHGEoFa4z8Ky0l6nt1wKIOEYRMbC/M3SUb9+eH1LvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AydA9CPz26rh7erAHjnyEw9bv1v12xnW/gTikep5Qk1swJY3vv9ctccjaCt6FfW05
         ApHAkNEG5JgCGYFOx9OwUR0qXbWT8czBjR1JNy0fzTsrvfM6I0uEwJ98UXQ00kFOvg
         dhpyk+/1j27qZdwU6er4zQRkH8kSfiSK17RL0vVY=
Date:   Tue, 30 Jun 2020 17:34:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] .gitignore: Do not track `defconfig` from `make
 savedefconfig`
Message-ID: <20200630153431.GB1785141@kroah.com>
References: <20200630142653.10375-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630142653.10375-1-pmenzel@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:26:53PM +0200, Paul Menzel wrote:
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

I know I require patches to have changelog text in them, maybe other
maintainers are more lax...
