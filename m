Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EEC1F1C04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgFHPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 11:25:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:47178 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbgFHPZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:25:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0603D35A;
        Mon,  8 Jun 2020 15:25:52 +0000 (UTC)
Date:   Mon, 8 Jun 2020 09:25:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: it_IT: address invalid reference warnings
Message-ID: <20200608092552.69c6dc3b@lwn.net>
In-Reply-To: <20200531185618.7099-1-lukas.bulwahn@gmail.com>
References: <20200531185618.7099-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 20:56:18 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Documentation generation warns:
> 
>   it_IT/kernel-hacking/hacking.rst:
>     WARNING: unknown document: ../core-api/symbol/namespaces
> 
>   it_IT/process/5.Posting.rst:
>     WARNING: undefined label: it_email_clients
> 
>   it_IT/process/submitting-patches.rst:
>     WARNING: undefined label: it_email_clients
> 
>   it_IT/process/howto.rst:
>      WARNING: undefined label: it_managementstyle
> 
> Refer to English documentation, as Italian translation does not exist,
> and add labels for Italian process documents to resolve label references.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jonathan, please pick this quick fix of warnings.

Applied, thanks.

jon
