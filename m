Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8F212266
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgGBLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 07:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBLff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:35:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E9F206B7;
        Thu,  2 Jul 2020 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593689735;
        bh=CFFtu5Zlg5EFXmXoeTvkwooaWY9hE66618FDsF/kWXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSq/FY5SIqUvVno02FqayWliD567dmauxr1jRDOslGiUMp3o62fapMLJt7kQeJP2p
         7FBXIVQvieTNMlO7U0EkjssH0CyImn0fHBGBvztBV80YozDJZLvzkZp1mSsUoEFHtQ
         TqUHqd2UgtszHwLWKx9C4MIjT4wa9t64C0ZBnRuo=
Date:   Thu, 2 Jul 2020 13:35:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] .gitignore: Do not track `defconfig` from `make
 savedefconfig`
Message-ID: <20200702113538.GA1667088@kroah.com>
References: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:12:00PM +0200, Paul Menzel wrote:
> Running `make savedefconfig` creates by default `defconfig`, which is,
> currently, on git’s radar, for example, `git status` lists this file as
> untracked.
> 
> So, add the file to `.gitignore`, so it’s ignored by git.
> 
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
