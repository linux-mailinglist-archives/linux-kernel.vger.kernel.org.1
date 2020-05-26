Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873951B5E25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgDWOos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 10:44:48 -0400
Received: from ms.lwn.net ([45.79.88.28]:44616 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:44:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8C8E930A;
        Thu, 23 Apr 2020 14:44:47 +0000 (UTC)
Date:   Thu, 23 Apr 2020 08:44:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     xujialu <xujialu@vimux.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, akpm@linux-foundation.org,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200423084446.7419f7d5@lwn.net>
In-Reply-To: <20200423143642.11788-2-xujialu@vimux.org>
References: <20200423103801.GA3730892@kroah.com>
        <20200423143642.11788-1-xujialu@vimux.org>
        <20200423143642.11788-2-xujialu@vimux.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 22:36:42 +0800
xujialu <xujialu@vimux.org> wrote:

> A script for generating gtags.files after compilation.
> 
> Signed-off-by: xujialu <xujialu@vimux.org>

Please, try to help out us poor folks who aren't a part of your world and
provide a proper changelog here.  What does this script do, why would one
want a "gtags.files" file, how does one run it, etc?  Additionally, the
script itself should have a comment describing what it does and how to run
it - somebody stumbling across it in 2030 may not just know that stuff.

Thanks,

jon
