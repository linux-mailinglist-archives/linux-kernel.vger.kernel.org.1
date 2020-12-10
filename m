Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7472D5AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbgLJMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbgLJMya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:54:30 -0500
Date:   Thu, 10 Dec 2020 13:55:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607604830;
        bh=gtqICGnsvOHitJ+qiT1LDw6ed/QH/+lGYZQH8qRXoqI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPfcBZx7Z1JquJ69v007RmtZtwB8tKa1oBqTdCU+tt0bnnPaH8rexkQVxiB9CuEG9
         zyShvqhCLw0HFkGcrkDjsIVw3iQ5GnVZZOz86lmI8FUIxiXKe0ZQ5Aru434oDqxmRt
         OogMivKa0jVQkeZWozG0TItmfUbFDv8wuUQFGooc=
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v1 1/2] Staging: silabs si4455 serial driver: fix
 directory structure and coding style
Message-ID: <X9Iaqd8cb7xBAI7S@kroah.com>
References: <20201210122057.GA31782@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210122057.GA31782@dincontrollerdev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:20:59PM +0000, József Horváth wrote:
> fix: coding style
> fix: error checking
> remove: doc silabs,si4455.txt

What does all of this mean?

Please read the documentation for how to write an effective changelog
text, and where to put the "changes from the first version" text at.

thanks,

greg k-h
