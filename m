Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9311F03F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 02:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgFFAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 20:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgFFAc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:32:29 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98F7206FA;
        Sat,  6 Jun 2020 00:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591403548;
        bh=etdUp3B0vqYUd+nc5rFMvGoJnmjYLoXk71S39txeHl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S053yADgRvLsPNg7M3ByHh0DoOa0u0yTTCKcCV5QHfm0kDoUSYQaV+HNyBye7UvID
         AT3LZe+hwZSC0fOOmy1jJtGwMSA4FNXoUhuYt3GZ7Q5uiUO5nlQjewTD9HteT6B02c
         8ABurbjY3/peDM2027FvfKbQohAsfq5UQ6v0sCt4=
Date:   Fri, 5 Jun 2020 17:32:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Add test for possible misuse of
 IS_ENABLED() without CONFIG_
Message-Id: <20200605173228.3c37b0f40b91c7291c52f750@linux-foundation.org>
In-Reply-To: <e7fda760b91b769ba82844ba282d432c0d26d709.camel@perches.com>
References: <202006050718.9D4FCFC2E@keescook>
        <e7fda760b91b769ba82844ba282d432c0d26d709.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jun 2020 11:24:43 -0700 Joe Perches <joe@perches.com> wrote:

> IS_ENABLED is almost always used with CONFIG_<FOO> defines.
> 
> Add a test to verify that the #define being tested starts with CONFIG_.

Yay.

I wonder if there's a simple way of testing whether the CONFIG_ thing
can *ever* be enabled.  So detect if someone does

	if (IS_ENABLED(CONFIG_BLOCKK))

