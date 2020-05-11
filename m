Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7AC1CE698
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbgEKVCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732073AbgEKVCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:02:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:02:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so5116955pgm.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSsJuiuQVhX5mi+0hDBDIBKGp39VuH2U96/o+lEhntI=;
        b=stiW8was2ZkQrskwkMD/u2MqfHNAkQB3uEQRKk2uZn0hcIA29HYKSr3aPf1ip6E+NJ
         FBhCXI0cO1MfkYL21OBWDivT/nxpnciW3X0O1EqTHGxnd8rpceTIlIywSF+1WmHuRxLd
         1eLOhrAeK4ff1GxvFOIr2SXkukkZy++YIzbggOIiW2e5u3u/lnt+5FDSuTgryx2rkQsp
         hQIPP9Z8tcIch+2lr4rzOjabDM15Elvzb+15SWvw/UA1FQisl+VB4bH375R7ztwqqNeE
         NeKVvvMeTtV9hM9NktOXPBE921OW8ecDMiTIWudZCcpglwaq+LZldC2cKOdGsPe/TkZz
         9NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sSsJuiuQVhX5mi+0hDBDIBKGp39VuH2U96/o+lEhntI=;
        b=i/GwAVdCVduRDKcK3I6n5m/mGsrGEnFmSZ48J0bIk8EApQNRHnfYK101ND4li35AAS
         DJPBRnGKi9U0XUK4Sm9SbZUJJajS1Sg7btlj7XhM666V7pB47jdg61ZY96ntX4yVWG60
         /rNlICoEFlUgVKEiCN2k02RTKocDhjiw136DKd64Yga15SOzGDAOwkyx/djiyVzPtSRB
         0NWIxWAsAngSyY0YBoh/5OgN9AaSkLqw7MALJRJStvjfveD04MXNOmyE8/+oOeQ2YDMh
         AyLu++04bx/GSSn4BsQW4WXrQy+E7luVCfLqBnZy2RGRPiiky8PJ1oA/bjBfWR9o97/U
         WFxg==
X-Gm-Message-State: AGi0Pubp3xoYBqVfQ6/sDuMzBDzHfT2shp1d/7oPOlfJkEpaJqsKvmJu
        k87qXtXST5ESOXjcLLMq5Do=
X-Google-Smtp-Source: APiQypJRVv554GH4F41XHegtP2kTtAQfKN5F1lohS2Cs+iIkrMulrtyKgFejve5HIUAqf2YdCxUfsA==
X-Received: by 2002:a63:5a41:: with SMTP id k1mr17002700pgm.424.1589230964794;
        Mon, 11 May 2020 14:02:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p24sm9899121pff.92.2020.05.11.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:02:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     eric@anholt.net, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Update Raspberry Pi development repository
Date:   Mon, 11 May 2020 14:02:42 -0700
Message-Id: <20200511210242.27892-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511110250.23869-1-nsaenzjulienne@suse.de>
References: <20200511110250.23869-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 13:02:50 +0200, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> Eric Anholt's repo isn't used anymore. List current one.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to maintainers/next, thanks!
--
Florian
