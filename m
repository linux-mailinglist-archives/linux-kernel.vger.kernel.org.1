Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66E019EB9F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDENuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 09:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgDENuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 09:50:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFF720672;
        Sun,  5 Apr 2020 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586094613;
        bh=bR1WXlMJEBNzWcKWcDl/QhYQj4ePiYgOHWnZdlwCXxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwsSCn0kr9vsqQUeCx5pEmdJhCy+R801Pa3w5MnT3N2gZHLFZq4XWdM5caunBHc1t
         RaaxfXlYG0yM0qH20ML8OsoIvoLKhfiBcI0boiQFlouNwBQJiZk2bLyWPZyl+/ARvf
         1hE+HyvrSn4qYUsUlWTu3DQ5AhMlhtYOF3RgTDJY=
Date:   Sun, 5 Apr 2020 15:50:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty: emove redundant assignment to variable i
 and rename it to ret
Message-ID: <20200405135005.GA1573947@kroah.com>
References: <20200405133013.380080-1-colin.king@canonical.com>
 <dd83c6dc-da74-e961-4a25-b6515742052a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd83c6dc-da74-e961-4a25-b6515742052a@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 02:35:43PM +0100, Colin Ian King wrote:
> Oops, typo on $SUBJECT, can "emove" be replaced with "remove" when this
> is applied?

It's easier if you fix it up and send it again, thanks.

greg k-h
