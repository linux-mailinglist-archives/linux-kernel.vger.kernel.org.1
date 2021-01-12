Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FE2F2CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405009AbhALK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbhALK1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:27:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEA0123109;
        Tue, 12 Jan 2021 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610447194;
        bh=ryhCQv8eVrVNeqK5clAMBRFTzJ4fSC4rPww2yGJmDSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmdVOqNnKfjR4p1cC+yIibA4jrFc6UxE983zY5Zc1KnzLGwHkiChODRcmvamELmlI
         x5dkKVIi4fG7WTia4rKVgfiWry3bQOdmrZBff407TX80ShCfH9BwtusXqk/YL5zMuR
         9Uuu/uFaK5x0RPvz9dLnRZHjaWn7HWadx8n8z2RA=
Date:   Tue, 12 Jan 2021 11:27:43 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Jozsef Horvath <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] Serial: silabs si4455 serial driver
Message-ID: <X/15n3lOU6F0GMPw@kroah.com>
References: <20210112101857.GA13976@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112101857.GA13976@dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:19:00AM +0000, Jozsef Horvath wrote:
> This is a device tree schema for serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Guide: Documentation/driver-api/serial/si4455.rst
> 
> Signed-off-by: Jozsef Horvath <info@ministro.hu>

You sent 2 different patches, that do different things, with the exact
same subject line.  Please make your commit messages unique, we can't
take this as-is.

thanks,

greg k-h
