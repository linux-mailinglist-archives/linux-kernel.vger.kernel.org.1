Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F241D11E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgEML4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 07:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgEML4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:56:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C18206CC;
        Wed, 13 May 2020 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589370963;
        bh=JBhLl7MfUCS5IJ2eW+T1ci2N1MDfEAyW0mk4rekhbUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fusTrhbqb2rs17wl1cCQHfTGLDTWjurXiZ1Y7GEjb8b1DT8LoWjlilieWU+14lzTY
         E95XDdkRx7fKAgSAnSYViVqqpUuNaxykiLdn4cj7jCksJUZybY1Trl39qQok52aydx
         skfqgeMIr2i+Yx8CdOrfdIac5IOn4RKQfCJ3Ew4M=
Date:   Wed, 13 May 2020 13:56:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matej Dujava <mdujava@kocurkovo.cz>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: vt6655: vt6656: change order of makefile
 variable definitions
Message-ID: <20200513115600.GB953616@kroah.com>
References: <1589105615-22271-1-git-send-email-mdujava@kocurkovo.cz>
 <1589105615-22271-3-git-send-email-mdujava@kocurkovo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589105615-22271-3-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:13:35PM +0200, Matej Dujava wrote:
> This patch will add indentation to multiline variable and put obj-$(CONFIG_X)
> at the begining of the file.

Why change the order?  What does that fix?  Why do this?  You say what
you do here, but not why.  And without that, I can't see the reason to
accept this patch :(

thanks,

greg k-h
