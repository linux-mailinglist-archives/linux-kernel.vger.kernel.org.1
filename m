Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47B627E2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgI3HlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:41:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44362 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:41:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6681F29AD2C
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] chrome: Use kobj_to_dev() instead
To:     Wang Qing <wangqing@vivo.com>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <1601103820-14002-1-git-send-email-wangqing@vivo.com>
Message-ID: <605f2193-e9ef-9e6a-4492-0cea620a2f18@collabora.com>
Date:   Wed, 30 Sep 2020 09:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601103820-14002-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang Qing,

Many thanks for your patch.

On 26/9/20 9:03, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Applied for 5.10

>  drivers/platform/chrome/cros_ec_sysfs.c | 2 +-
>  drivers/platform/chrome/cros_ec_vbc.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index d45ea5d..a643ea8
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -326,7 +326,7 @@ static struct attribute *__ec_attrs[] = {
>  static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
>  				    struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>  
>  	if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index 46482d1..f3a70a3
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -17,7 +17,7 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>  				  struct bin_attribute *att, char *buf,
>  				  loff_t pos, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>  	struct cros_ec_device *ecdev = ec->ec_dev;
>  	struct ec_params_vbnvcontext *params;
> @@ -57,7 +57,7 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
>  				   struct bin_attribute *attr, char *buf,
>  				   loff_t pos, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>  	struct cros_ec_device *ecdev = ec->ec_dev;
>  	struct ec_params_vbnvcontext *params;
> 
