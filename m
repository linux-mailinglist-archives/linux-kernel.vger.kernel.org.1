Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08C211D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGBHlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 03:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgGBHk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:40:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A282089D;
        Thu,  2 Jul 2020 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593675659;
        bh=fu9AbKs4fpI0bDe695/+sT0YsRDwFK4WhDeSDfHQTyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2vd0Ujg7wjIiNrvcXPJx5TKUUjNOAFqW3VdWYhIzyoe2WMRtRdseemJy/P3lJQ5N
         8r8foAXsfcf7++J+w0oH+QgtVUvAqvTZkJegzji6imm8fxSwJ1oyLRvV45adulcbuO
         zdC6OyftGbLbsNyNfI8JX0z1I4GHJsOJ2Ar2TbVg=
Date:   Thu, 2 Jul 2020 09:41:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 8/8] ktest.pl: Add MAIL_MAX_SIZE to limit the
 amount of log emailed
Message-ID: <20200702074103.GA1076415@kroah.com>
References: <20200701231717.757834010@goodmis.org>
 <20200701231756.790637968@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701231756.790637968@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 07:17:25PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add the ktest config option MAIL_MAX_SIZE that will limit the size of the
> log file that is placed into the email on failure.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/testing/ktest/ktest.pl    | 12 +++++++++++-
>  tools/testing/ktest/sample.conf | 13 +++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)

Interesting, but I like full log files for my reports :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
