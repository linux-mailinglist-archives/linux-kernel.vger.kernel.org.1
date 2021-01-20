Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C952FD4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbhATP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:58:21 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37061 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389590AbhATPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:50:36 -0500
Received: by mail-oi1-f173.google.com with SMTP id r189so15823822oih.4;
        Wed, 20 Jan 2021 07:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYbx2xe32XFhOVL3J3Pp49OQN2yzd40W6CTKKFcuuLs=;
        b=eD3/44yLzTVrioqZqsyF6ywRSp8JBt8P5yn2Ipzxx7mEjbPwh2iYGb3ydtACHfUrBb
         a0glNwwxuWGfk/7qVdVFQbMt+QOZxZN7ba0vftjJPi4HywyqWCWtC5dyCXSxlJy01/10
         I83uo3i2NG64SIBNqVunnOBeGfRAecMjx8Z9i8OARhonZ/T6n+sfaehEYh3aFVgeDVBv
         /fVHPtHA+3RlBGHk35gxuOMjzJvZFnqLBpL0lZ1WPGNUgJHQrZUX52MbZvHYqUSUmzBf
         K4oEwPSJNAQ4fWVqmhLZlpMg8syHRap+OS3Dr3zOJl5q98orDOkxFNZh6NfqtmE250Iy
         RBXA==
X-Gm-Message-State: AOAM531+vsozdglEhQX/VbdllQGtBVUh7O9uiGZvqWRpQtt2NJuN9AkM
        1AFnQgMPjESznEZE1jh25mmf7kdHKw==
X-Google-Smtp-Source: ABdhPJwE5LbLqu6tO4VBPYKT84ed6pwNWrxXdXwW/G4xSoU8ui32yzPJo+C9nCvqTiNUldKGUoGmcg==
X-Received: by 2002:aca:b2c3:: with SMTP id b186mr3318985oif.135.1611157795183;
        Wed, 20 Jan 2021 07:49:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 186sm424754ood.6.2021.01.20.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 07:49:54 -0800 (PST)
Received: (nullmailer pid 213140 invoked by uid 1000);
        Wed, 20 Jan 2021 15:49:52 -0000
Date:   Wed, 20 Jan 2021 09:49:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philip Chen <philipchen@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>, dianders@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org,
        dmitry.torokhov@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: input: Create macros for cros-ec
 keymap
Message-ID: <20210120154952.GA212597@robh.at.kernel.org>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 14:36:15 -0800, Philip Chen wrote:
> In Chrome OS, the keyboard matrix can be split to two groups:
> 
> The keymap for the top row keys can be customized based on OEM
> preference, while the keymap for the other keys is generic/fixed
> across boards.
> 
> This patch creates marcos for the keymaps of these two groups, making
> it easier to reuse the generic portion of keymap when we override the
> keymap in the board-specific dts for custom top row design.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Rename CROS_STD_NON_TOP_ROW_KEYMAP to CROS_STD_MAIN_KEYMAP
> 
>  include/dt-bindings/input/cros-ec-keyboard.h | 103 +++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 include/dt-bindings/input/cros-ec-keyboard.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

