Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD1267E36
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIMGwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 02:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgIMGwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 02:52:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360FB20758;
        Sun, 13 Sep 2020 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599979953;
        bh=QYxREwuDAmQft3utqpHUZWUl1/sO/MnfcFBotp09uMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSiv3SlCHvXqrRD+4mHXIyycAUKcmDOAyonfvyBMOjHdeMBV6FaDm6WCZobPNhqBH
         acSia+4CxwrCA7vtPBJ8kvg0gzlXqlEzL/AMF1NupwbDP0t3iokPxpsDwmhSNwOv9o
         TVYLGTdGU+JAsIPKPNSWjos9mt9dQuioZO01FXbQ=
Date:   Sun, 13 Sep 2020 08:52:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sohom Datta <sohom.datta@learner.manipal.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
 (checkpatch)
Message-ID: <20200913065229.GA605627@kroah.com>
References: <230f781dcaadfc797a016cc6036d63efe6542062.camel@learner.manipal.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230f781dcaadfc797a016cc6036d63efe6542062.camel@learner.manipal.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 12:19:50PM +0530, Sohom Datta wrote:
> >From 4c8c8f3ff7f4d711daea4ac3bb987fcecc7ef1ed Mon Sep 17 00:00:00 2001
> From: Sohom <sohom.datta@learner.manipal.edu>
> Date: Sat, 12 Sep 2020 18:04:56 +0530
> Subject: [RESEND PATCH] staging: rtl8188eu: Fix else after return WARNING
>  (checkpatch)

Why is this in the body of your email?

Just use 'git send-email' to send the patch, no need to include it in
the body itself, right?

thanks,

greg k-h
