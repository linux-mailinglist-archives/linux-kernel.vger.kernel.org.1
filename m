Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094521B19E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 01:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDTXEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 19:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:03:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB8C061A0E;
        Mon, 20 Apr 2020 16:03:59 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 419E8536;
        Mon, 20 Apr 2020 23:03:59 +0000 (UTC)
Date:   Mon, 20 Apr 2020 17:03:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Cristian Souza <cristianmsbr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH v4] docs: admin-guide: Clarify sentences
Message-ID: <20200420170358.7dafa798@lwn.net>
In-Reply-To: <20200411010201.GA22706@darkstar>
References: <20200411010201.GA22706@darkstar>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 22:02:01 -0300
Cristian Souza <cristianmsbr@gmail.com> wrote:

> Changes to make the text more formal and organized. The reasons are now cited and described at the same time.
> Minor grammatical problems have also been fixed.
> 
> Signed-off-by: Cristian Souza <cristianmsbr@gmail.com>
> ---
> Changes in v2:
>  - Text more formal and organized
> Changes in v3:
>  - Authors at the top of the file
>  - Removal of the source file in which the message is located
>  - All lines under 80 characters
> Changes in v4:
>  - Diff against mainline
> 
>  Documentation/admin-guide/init.rst | 76 ++++++++++++++----------------
>  1 file changed, 36 insertions(+), 40 deletions(-)

Applied, thanks.

jon
