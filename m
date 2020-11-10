Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D82ADCAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKJROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:14:54 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:50799 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKJROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:14:53 -0500
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
        by plasma.jpberlin.de (Postfix) with ESMTP id 7D417AAF87;
        Tue, 10 Nov 2020 18:14:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([91.198.250.140])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 7IupmUzPuzD2; Tue, 10 Nov 2020 18:14:47 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id D88F1A6138;
        Tue, 10 Nov 2020 18:14:46 +0100 (CET)
Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 timestamped reads
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <lukasz.luba@arm.com>, <james.quinlan@broadcom.com>,
        <Jonathan.Cameron@Huawei.com>, <egranata@google.com>,
        <jbhayana@google.com>, <mikhail.golubev@opensynergy.com>,
        <Igor.Skalkin@opensynergy.com>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-5-cristian.marussi@arm.com>
 <69e5ba10-47a5-ca14-103a-03e94f410618@opensynergy.com>
 <20201110170429.GD42652@e120937-lin>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; prefer-encrypt=mutual; keydata=
 mQGNBFuyHTIBDAClsxKaykR7WINWbw2hd8SjAU5Ft7Vx2qOyRR3guringPRMDvc5sAQeDPP4
 lgFIZS5Ow3Z+0XMb/MtbJt0vQHg4Zi6WQtEysvctmAN4JG08XrO8Kf1Ly86Z0sJOrYTzd9oA
 JoNqk7/JufMre4NppAMUcJnB1zIDyhKkkGgM1znDvcW/pVkAIKZQ4Be3A9297tl7YjhVLkph
 kuw3yL8eyj7fk+3vruuEbMafYytozKCSBn5pM0wabiNUlPK39iQzcZd8VMIkh1BszRouInlc
 7hjiWjBjGDQ2eAbMww09ETAP1u38PpDolrO8IlTFb7Yy7OlD4lzr8AV+a2CTJhbKrCJznDQS
 +GPGwLtOqTP5S5OJ0DCqVHdQyKoZMe1sLaZSPLMLx1WYAGN5R8ftCZSBjilVpwJ3lFsqO5cj
 t5w1/JfNeVBWa4cENt5Z0B2gTuZ4F8j0QAc506uGxWO0wxH1rWNv2LuInSxj8d1yIUu76MqY
 p92TS3D4t/myerODX3xGnjkAEQEAAbQ7cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbSA8
 cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT6JAc4EEwEIADgCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXXd8PQAKCRAiPT9iQ46MN1PT
 C/4mgNGlWB1/vsStNH+TGfJKt3eTi1Oxn6Uo0y4sXzZg+CHXYXnrG2OdLgOa/ZdA+O/o1ofU
 v/nLKki7XH/cGsOtZ6n3Q5+irkLsUI9tcIlxLCZZlgDPqmJO3lu+8Uf2d96udw/5JLiPyhk/
 DLtKEnvIOnn2YU9LK80WuJk7CMK4ii/bIipS6WFV6s67YG8HrzMKEwIzScf/7dC/dN221wh0
 f3uUMht0A7eVOfEuC/i0//Y+ytuoPcqyT5YsAdvNk4Ns7dmWTJ8MS2t2m55BHQnYh7UBOIqB
 BkEWLOxbs2zZnC5b/yjg7FOhVxUmSP4wU1Tp/ye+MoVhiUXwzXps5JmOuKahLbIysIpeRNxf
 B8ndHEjKRl6YglPtqwJ45AF+BFEcblLe4eHk3Gl43jfoBJ43jFUSkge9K7wddB2FpaXrpfwM
 KupTSWeavVwnjDb+mXfqr4e7C4CX3VoyBQvoGGPpK/93cVZInu5zV/OAxSayXt6NqZECkMBu
 mg7W7hbcQey0K1BldGVyIEhpbGJlciA8cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT6J
 Ac4EEwEIADgWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXjAOKgIbAwULCQgHAgYVCgkICwIE
 FgIDAQIeAQIXgAAKCRAiPT9iQ46MN6G+C/0R2UCwDr4XdHCjDETK+nGzwEADTkb/bVvnSP8U
 1XpoNuFoG0hpx/L9IOacxKCUwL5wGLQ2YjqfmWl5h5nwL/VmisSjtDBU/E9Te825J6avxyXm
 aSYehTMlBNgGq6gTgGZ2UywbTx51iPtbtqk5IWQSrJfhHgegyapOvDIe3W/L7WdWhpEUAOS2
 Rn1pW//rR1RZW0aCuQSi8eT+HKiFid84Kh9x858oNRc9W1bCGjmkFxyhJdxlF7SdwgFahJDm
 JHfdRyBcpp31WyofNodzNi/39gnrYbxyQmMSMU6Wi5Y9QIGubBB6BN+JlqL0WKgWfyye/6dp
 R6BrgRLUHBXFegWWLVvQGDli31kXBT0Aey9GQs2sEG3yoYHRAi9/dOip+rJgzqc+k6exP13g
 ZNBPc5SCrhWk9B/VrZ+frVBhqbu0hYlAnX39cB4szyOJVkGvXPJ6vsewQBv486kIY7IDC+Rk
 YtC1zNZKSIWSK1+bIXrIBA45rWb6SGq0CgMYdMvUGd25AY0EW7IdMwEMANZOEgW7gpZr0l4M
 HVvEZomKRgHmKghiKffCyR/cZdB5CWPEsyD0QMkQCQHg0FUQIB/SyS7hV/MOYL47Zb+QUlBo
 sMGkyyseEBWx0UgxgdMOh88JxAEHs0gQFYjL13DFLX/JfPyUqEnmWHLmvPpwPy2Qp7M1PPYb
 /KT8YxQEcJ0agxiSSGC+0c6efziPLW1uvGnQpBXhbLRdmUVS9JE390vQLCjIQWQP34e6MnKr
 ylqPpOeaiVSC9Nvr44f7LDk0X3Hsg3b4kV9TInGcbskXCB9QnKo6lVgXI9Q419WZtI9T/d8n
 5Wx54P+iaw4pISqDHi6v+U9YhHACInqJm8S4WhlRIXhXmDVXBjyPvMkxEYp9EGxT5yeu49fN
 5oB1SQCf819obhO7GfP2pUx8H3dy96TvKFEQmuh15iXYCxgltrvy9TjUIHj9SbKiaXW1O45t
 jlDohZJofA0AZ1gU0X8ZVXwqn3vEmrMLDBiko3gdBy7mx2vl+Z1LJyqYKBBvw+pi7wARAQAB
 iQG2BBgBCAAgAhsMFiEE4+UwmTdY2H45eYsEIj0/YkOOjDcFAl13fD0ACgkQIj0/YkOOjDfF
 hwv9F6qVRBlMFPmb3dWIs+QcbdgUW9ViGOHNyjCnr+UBE5jc0ERP3IOzcgqavcL5YpuWadfP
 n4/LyMDhVcl5SQGIdk5oZlRWQRiSpqS+IIU8idu+Ogl/Hdsp4n9S8GiINNwNh5KzWoCNN0Pp
 crjuMTacJnZur9/ym9tjr+mMvW7Z0k52lnS9L+CRHLKHpVJSnccpTpShQHa335c5YvRC8NN+
 Ygj1uZL/98+1GmP1WMZ6nc1LSFDUxR60cxnlbgH7cwBuy8y5DBeCCYiPHKBglVIp5nUFZdLG
 /HmufQT3f4/GVoDEo2Q7H0lq3KULX1xEwHFeXHw4NXR7mYeX/eftz/9GFMVU29c72NTw8Uih
 Oy9qJgNo19wroRYKHLz1eWtMVcqS3hbXm0/QcrG9+C9qCPXVxpC/L0YLAtmdvEIyaFtXWRyW
 7UQ3us6klHh4XUvSpsQhOgzLHFJ1LpfcupeBYECJQdxgIYyhgFAwRHeLGIPxjlvUmk22C0ua
 lbekkuPTQs/m
Message-ID: <0c9edbcb-2a7c-d564-f0be-2f48f64e1854@opensynergy.com>
Date:   Tue, 10 Nov 2020 18:14:44 +0100
MIME-Version: 1.0
In-Reply-To: <20201110170429.GD42652@e120937-lin>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.74 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7D417AAF87
X-Rspamd-UID: 505dda
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.20 18:04, Cristian Marussi wrote:
> Hi Peter
> 
> thanks for the review.
> 
> On Tue, Nov 10, 2020 at 05:01:26PM +0100, Peter Hilber wrote:
>> On 26.10.20 21:10, Cristian Marussi wrote:
>>> Add new .reading_get_timestamped() method to sensor_ops to support SCMIv3.0
>>> timestamped reads.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>  drivers/firmware/arm_scmi/sensors.c | 134 ++++++++++++++++++++++++++--
>>>  include/linux/scmi_protocol.h       |  22 +++++
>>>  2 files changed, 151 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
>>> index 5a18f8c84bef..bdb0ed0df683 100644
>>> --- a/drivers/firmware/arm_scmi/sensors.c
>>> +++ b/drivers/firmware/arm_scmi/sensors.c
>>> @@ -156,6 +156,27 @@ struct scmi_msg_sensor_reading_get {
>>>  #define SENSOR_READ_ASYNC  BIT(0)
>>>  };
>>>
>>> +struct scmi_resp_sensor_reading_get {
>>> +   __le64 readings;
>>> +};
>>> +
>>> +struct scmi_resp_sensor_reading_complete {
>>> +   __le32 id;
>>> +   __le64 readings;
>>> +};
>>
>> In my understanding the id field is not present in the spec. The
>> implementation seems to have introduced it already before this patch.
>>
> 
> Well, it is indeed defined in 4.7.3.1 "SENSOR_READING_COMPLETE" both in
> SCMI V3.0 and in V2.0: it is the async delayed response and this 'id'
> represents the sensor_id: in fact it is used only the in the async path
> in the reading funcs; the sync version uses directly sensor_reading_le.
> (which has no id n it)

You are right, sorry for the noise.

>>> +/**
>>> + * scmi_sensor_reading_get  - Read scalar sensor value
>>> + * @handle: Platform handle
>>> + * @sensor_id: Sensor ID
>>> + * @value: The 64bit value sensor reading
>>> + *
>>> + * This function returns a single 64 bit reading value representing the sensor
>>> + * value; if the platform SCMI Protocol implementation and the sensor support
>>> + * multiple axis and timestamped-reads, this just returns the first axis while
>>> + * dropping the timestamp value.
>>> + * Use instead the @scmi_sensor_reading_get_timestamped to retrieve the array of
>>> + * timestamped multi-axis values.
>>> + *
>>> + * Return: 0 on Success
>>> + */
>>>  static int scmi_sensor_reading_get(const struct scmi_handle *handle,
>>>                                u32 sensor_id, u64 *value)
>>>  {
>>> @@ -593,18 +629,105 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
>>
>> How about changing the scmi_xfer_get_init() rx_size to 0 (in the
>> immediately preceding, not shown lines)? An SCMI platform might not
>> expect to just have room for the first reading, excluding the timestamp.
>>
> 
> Ah right, because this is the old v2.0 interface which I kept unchanged but
> now internally the same v3.0 SENSOR_READING_GET message on a v3.0 platform
> could return multiple per-axis timestamped values even if I just return
> the first u64 without timestamp. Is this that you mean ?

Yes.

Best regards,

Peter
