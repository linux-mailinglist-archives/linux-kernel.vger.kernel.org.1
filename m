Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4852F4AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbhAMLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbhAMLtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:49:07 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F36233ED;
        Wed, 13 Jan 2021 11:48:27 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kzedV-007F2l-3X; Wed, 13 Jan 2021 11:48:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 13 Jan 2021 11:48:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
In-Reply-To: <712cb4237f1dbb8d1104736e20713ba457444650.camel@suse.de>
References: <20201218031703.3053753-1-saravanak@google.com>
 <712cb4237f1dbb8d1104736e20713ba457444650.camel@suse.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <44201af052a70efd42f7ff5a2125316c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: nsaenzjulienne@suse.de, saravanak@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, kernel-team@android.com, linux-kernel@vger.kernel.org, Jisheng.Zhang@synaptics.com, khilman@baylibre.com, john.stultz@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-13 11:44, Nicolas Saenz Julienne wrote:
> On Thu, 2020-12-17 at 19:16 -0800, Saravana Kannan wrote:
>> As discussed in LPC 2020, cyclic dependencies in firmware that 
>> couldn't
>> be broken using logic was one of the last remaining reasons
>> fw_devlink=on couldn't be set by default.
>> 
>> This series changes fw_devlink so that when a cyclic dependency is 
>> found
>> in firmware, the links between those devices fallback to permissive 
>> mode
>> behavior. This way, the rest of the system still benefits from
>> fw_devlink, but the ambiguous cases fallback to permissive mode.
>> 
>> Setting fw_devlink=on by default brings a bunch of benefits 
>> (currently,
>> only for systems with device tree firmware):
>> * Significantly cuts down deferred probes.
>> * Device probe is effectively attempted in graph order.
>> * Makes it much easier to load drivers as modules without having to
>>   worry about functional dependencies between modules (depmod is still
>>   needed for symbol dependencies).
> 
> FWIW I don't see any issues with this on Raspberry Pi 4 :).

Keep bragging! ;-)

         M.
-- 
Jazz is not dead. It just smells funny...
