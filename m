Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC7261B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgIHTBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:01:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54670 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbgIHQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:08:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 72A6129912E
Subject: Re: [PATCH] regmap: debugfs: potentially duplicate the name string of
 the config
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
References: <20200908152859.26279-1-dafna.hirschfeld@collabora.com>
 <20200908153559.GF5551@sirena.org.uk>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <455274f0-718c-9247-da29-6122687720eb@collabora.com>
Date:   Tue, 8 Sep 2020 18:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908153559.GF5551@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for the fast review,

Am 08.09.20 um 17:35 schrieb Mark Brown:
> On Tue, Sep 08, 2020 at 05:28:59PM +0200, Dafna Hirschfeld wrote:
>> In function regmap_debugfs_init the name of the regmap_config is assigned
>> in a node of regmap_debugfs_early_list to be used later after regmap
>> is initialized. It is unknown how and when the name is allocated and freed.
>> Therefore the name should be copied to the node using 'kstrdup_const'.
> 
> It does not follow that the name should be copied, it equally follows
> (and is expected by the API given that the common case is that the name
> is a static string assigned at build time) that the caller should not
> free the string while the regmap is active.

I see that the same copy is already done in function __regmap_init in drivers/base/regmap/regmap.c
added in patch 8253bb3f82554 "regmap: potentially duplicate the name string stored in regmap"
so I thought I'll do the same.

> 
>> This fixes an error
>> "debugfs: Directory 'dummy-' with parent 'regmap' already present!"
>> where the name was freed in function of_syscon_register before
>> it was accessed.
> 
> Fix the caller.  It is *very* much unclear to me why a syscon would be
> assigning a name for a regmap it creates in the first place.

I'll have a deeper look.

Thanks,
Dafna

> 
