Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85022FA203
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404802AbhARNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:47:32 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:60566 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404847AbhARNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:46:02 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 08:46:01 EST
Received: from fiber.protonic.nl (edge2.prtnl [192.168.1.170])
        by sparta.prtnl (Postfix) with ESMTP id CCE4944A022A;
        Mon, 18 Jan 2021 14:36:50 +0100 (CET)
MIME-Version: 1.0
Date:   Mon, 18 Jan 2021 14:36:50 +0100
From:   robin <robin@protonic.nl>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] auxdisplay: ht16k33: Improvement, fix, and
 json-schema conversion
Reply-To: robin@protonic.nl
In-Reply-To: <20210118123538.564597-1-geert@linux-m68k.org>
References: <20210118123538.564597-1-geert@linux-m68k.org>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <14593d82cd227439a9763d6277186f76@protonic.nl>
X-Sender: robin@protonic.nl
Organization: Protonic Holland
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for (re-)submitting your patches!

On 2021-01-18 13:35, Geert Uytterhoeven wrote:
> Hi Robin, Rob, Miguel,
> 
> This patch series contains various updates for the Holtek HT16K33 LED
> controller with keyscan DT bindings and driver:
>   1. Make the keypad function optional, from an old patch by Robin that 
> seem to
>      have fallen through the cracks,

Thanks for digging this up. Not sure why this was dropped. I still think 
it's usefull.

>   2. Fix the default brightness range,

Seems to match MIN/MAX_BRIGHTNESS now.
Acked-by: Robin van der Gracht <robin@protonic.nl>

Robin
