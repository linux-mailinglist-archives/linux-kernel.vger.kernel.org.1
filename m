Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5921AFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgGJGty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 02:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:49:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2872076A;
        Fri, 10 Jul 2020 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594363793;
        bh=bRWuQNkHECWTyQMZsQP4+1acSBX7AB0jqxNKFd5+IKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAmQ2WbkDIRI1296wzyNiDZT5X9/7PzqcS9UDvAAtieatcfiyuXzMB5l5QR0O7/fc
         4iXBw7koBCCIyIbp4MZomBPe16GboVTNO7NLg4C6vg1UEka0GbL8N5C7de20KUnfAW
         eZ++N5UqN3m33PTqGVksc6gQ7tVuZPYvCVBDdnMg=
Date:   Fri, 10 Jul 2020 08:49:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <20200710064958.GA1116538@kroah.com>
References: <202007091110.205DC6A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007091110.205DC6A9@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:11:30AM -0700, Kees Cook wrote:
> The security contact list gets regular reports contained in archive
> attachments. This tends to add some back-and-forth delay in dealing with
> security reports since we have to ask for plain text, etc.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for this, that will hopefully keep us from having to say the same
thing over and over :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
