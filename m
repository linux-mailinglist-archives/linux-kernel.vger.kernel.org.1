Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937961F891E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFNOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 10:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNOFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:05:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB6D2068E;
        Sun, 14 Jun 2020 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592143534;
        bh=0mFPGq9ZQ3DaTv72v947D8KCJ0CgZsUjqDrhCodkraY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sW1P1kjYmycL7YPadTEgKDzwhmyN3gHb1LVXHfZnFBUJAkuItTfwE0tLU4W6ZCgKw
         hyRQvkGzC2AZHphuHIneL5rqvVEo5wB+zcB9hS7i61SUZH+fseDj/r1C1BuvPdnzbA
         qMVY5IdbEPH+EFyph2oLMbWw1FvISelJouRZj5Eg=
Date:   Sun, 14 Jun 2020 16:05:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ferreira <rikajff@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Staging: rtl8712: Addressed checkpatch.pl issues related
 to macro parameter wrapping in parentheses.
Message-ID: <20200614140531.GA2661398@kroah.com>
References: <20200614135125.19502-1-rikajff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614135125.19502-1-rikajff@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 02:51:25PM +0100, Ricardo Ferreira wrote:
>  #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
>  do {\
> -	INIT_LIST_HEAD(&pcmd->list);\
> -	pcmd->cmdcode = code;\
> -	pcmd->parmbuf = (u8 *)(pparm);\
> -	pcmd->cmdsz = sizeof(*pparm);\
> -	pcmd->rsp = NULL;\
> -	pcmd->rspsz = 0;\
> +	INIT_LIST_HEAD(&(pcmd)->list);\
> +	(pcmd)->cmdcode = code;\
> +	(pcmd)->parmbuf = (u8 *)((pparm));\
> +	(pcmd)->cmdsz = sizeof(*(pparm));\
> +	(pcmd)->rsp = NULL;\
> +	(pcmd)->rspsz = 0;\
>  } while (0)

Does that change really make any sense?  checkpatch is a nice hint,
sometimes it is not correct...
