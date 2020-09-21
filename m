Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA9271E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIUIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIUIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:55:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF111C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:55:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5AAA9296585
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Update
 cros_ec_cmd_xfer() call-sites
To:     Gwendal Grignou <gwendal@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200903095415.2572049-1-pmalani@chromium.org>
 <1e2de378-5f5b-939e-39d8-00d6cc5ab6c8@collabora.com>
 <CACeCKaeNbhcoxCUkTJ1=jxGff5tNsSm4w7NdPe9=7dhUE7baqA@mail.gmail.com>
 <CAPUE2usvG43vTNGipQp8Q5DsvJqXKLggZ-TH4m+vkMi249v_nA@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f4344469-9115-9b7b-7ace-8fdec819430d@collabora.com>
Date:   Mon, 21 Sep 2020 10:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPUE2usvG43vTNGipQp8Q5DsvJqXKLggZ-TH4m+vkMi249v_nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant and Gwendal,

On 19/9/20 1:38, Gwendal Grignou wrote:
> On Mon, Sep 14, 2020 at 4:29 PM Prashant Malani <pmalani@chromium.org> wrote:
>>
>> Thanks Enric,
>>
>> On Mon, Sep 7, 2020 at 3:48 AM Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>>
>>> Hi Prashant,
>>>
>>> Thank you for your patch.
>>>
>>> On 3/9/20 11:54, Prashant Malani wrote:
>>>> Since all the other call-sites of cros_ec_cmd_xfer() have been converted
>>>> to use cros_ec_cmd_xfer_status() instead, update the remaining
>>>> call-sites to prepare for the merge of cros_ec_cmd_xfer() into
>>>> cros_ec_cmd_xfer_status().
>>>>
>>>> As part of this update, change the error handling inside
>>>> cros_ec_get_sensor_count() such that the legacy LPC interface is tried
>>>> on all error values, not just when msg->result != EC_RESULT_SUCCESS.
>>>>
>>>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> 
> There is a slight change in API in cros_ec_get_sensor_count(): it will
> return a negative number of sensors when there
> are no sensors on arm platform when MOTIONSENSE_CMD_DUMP is not
> supported (typical for sensorless chromebook) instead of 0.
> However, this is not a problem when probing the EC as we ignore errors
> only looking for cros_ec_get_sensor_count() returning a positive
> number of sensors.
> 

I added this comment to the commit log and applied the patch for 5.10.

Thanks,
  Enric

>>>
>>> Gwendal, I'd like to hear from you regarding this patch as you're the one that
>>> know most about the corner cases for the sensors in different hardware. Could
>>> you take a look and give us your Reviewed tag if all is good?
>>>
>> Gwendal, could you kindly take a look? Thanks!
>>
>>> Thanks,
>>>
>>>  Enric
>>>
>>>> ---
>>>>  drivers/platform/chrome/cros_ec_proto.c | 15 ++++-----------
>>>>  1 file changed, 4 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>>>> index dda182132a6a..2cb1defcdd13 100644
>>>> --- a/drivers/platform/chrome/cros_ec_proto.c
>>>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>>>> @@ -650,7 +650,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>>>>       msg->insize = size;
>>>>       msg->outsize = 0;
>>>>
>>>> -     ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>> +     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
>>>>       if (ret > 0) {
>>>>               ec_dev->event_size = ret - 1;
>>>>               ec_dev->event_data = *event;
>>>> @@ -694,7 +694,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
>>>>       msg->insize = sizeof(ec_dev->event_data.data);
>>>>       msg->outsize = 0;
>>>>
>>>> -     ec_dev->event_size = cros_ec_cmd_xfer(ec_dev, msg);
>>>> +     ec_dev->event_size = cros_ec_cmd_xfer_status(ec_dev, msg);
>>>>       ec_dev->event_data.event_type = EC_MKBP_EVENT_KEY_MATRIX;
>>>>       memcpy(&ec_dev->event_data.data, msg->data,
>>>>              sizeof(ec_dev->event_data.data));
>>>> @@ -883,11 +883,9 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>>>>       params = (struct ec_params_motion_sense *)msg->data;
>>>>       params->cmd = MOTIONSENSE_CMD_DUMP;
>>>>
>>>> -     ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
>>>> +     ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>>>>       if (ret < 0) {
>>>>               sensor_count = ret;
>>>> -     } else if (msg->result != EC_RES_SUCCESS) {
>>>> -             sensor_count = -EPROTO;
>>>>       } else {
>>>>               resp = (struct ec_response_motion_sense *)msg->data;
>>>>               sensor_count = resp->dump.sensor_count;
>>>> @@ -898,9 +896,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>>>>        * Check legacy mode: Let's find out if sensors are accessible
>>>>        * via LPC interface.
>>>>        */
>>>> -     if (sensor_count == -EPROTO &&
>>>> -         ec->cmd_offset == 0 &&
>>>> -         ec_dev->cmd_readmem) {
>>>> +     if (sensor_count < 0 && ec->cmd_offset == 0 && ec_dev->cmd_readmem) {
>>>>               ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
>>>>                               1, &status);
>>>>               if (ret >= 0 &&
>>>> @@ -915,9 +911,6 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>>>>                        */
>>>>                       sensor_count = 0;
>>>>               }
>>>> -     } else if (sensor_count == -EPROTO) {
>>>> -             /* EC responded, but does not understand DUMP command. */
>>>> -             sensor_count = 0;
>>>>       }
>>>>       return sensor_count;
>>>>  }
>>>>
