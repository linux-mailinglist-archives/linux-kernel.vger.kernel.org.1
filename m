Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A222F3AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436964AbhALTpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:45:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:50556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406904AbhALTpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:45:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD376AF55;
        Tue, 12 Jan 2021 19:44:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux@roeck-us.net
Cc:     a.seppala@gmail.com, boris@konbu.org, dianders@chromium.org,
        gregkh@linuxfoundation.org, hminas@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFT PATCH 0/4] usb: dwc2: Fixes and improvements
Date:   Tue, 12 Jan 2021 20:44:16 +0100
Message-Id: <20210112194416.27855-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200226210414.28133-1-linux@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,
I found patches #2 and #3 fixed an issue for us at suse. Are you planning on
sending a v2? Do you mind if I give it a try?

Regards,
Nicolas
